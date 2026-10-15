FROM steamcmd/steamcmd:ubuntu-24@sha256:ac6cc4b95a57f84990aebb9c8667bd859e5bb2d4b6640c8e7305cad62fd6c7e2 AS builder

ARG GE_PROTON_VERSION="11-9"
# Publisher's GE-Proton11-9-x86_64.sha512sum; update with the version.
ARG GE_PROTON_SHA512="30160946a5e4ffdf1f29d6f83a3d27108f6aa71b6aa59095b2c2260fe3a003b62acf8fdcb02a3dfc602b28473f5679d8a3eaee5a8adb141c1dfa01c42888da2d"

# Install prerequisites
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        curl \
        tar \
        dbus \
    && apt autoremove --purge && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install proton
RUN curl -fSL --retry 3 -o /tmp/ge-proton.tar.gz "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton${GE_PROTON_VERSION}/GE-Proton${GE_PROTON_VERSION}-x86_64.tar.gz" \
    && printf '%s  /tmp/ge-proton.tar.gz\n' "$GE_PROTON_SHA512" | sha512sum -c - \
    && mkdir -p /tmp/proton \
    && tar -xzf /tmp/ge-proton.tar.gz -C /tmp/proton --strip-components=1 \
    && rm /tmp/ge-proton.tar.gz \
    && rm -f /etc/machine-id \
    && dbus-uuidgen --ensure=/etc/machine-id


FROM steamcmd/steamcmd:ubuntu-24@sha256:ac6cc4b95a57f84990aebb9c8667bd859e5bb2d4b6640c8e7305cad62fd6c7e2
LABEL maintainer="docker@mornedhels.de"

# Install dependencies
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        curl \
        supervisor \
        cron \
        rsyslog \
        jq \
        zip \
        python3 \
        python3-pip \
        libfreetype6 \
        libfreetype6:i386 \
        libvulkan1 \
    && apt autoremove --purge && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install winetricks (unused)
RUN curl -o /tmp/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
    && chmod +x /tmp/winetricks && install -m 755 /tmp/winetricks /usr/local/bin/winetricks \
    && rm -rf /tmp/*

# Refresh the base image's bundled Steam client before linking the SDK copies.
RUN /usr/bin/steamcmd +quit

# MISC
RUN mkdir -p /usr/local/etc /var/log/supervisor /var/run/enshrouded /usr/local/etc/supervisor/conf.d/ /opt/enshrouded /home/enshrouded/.steam/sdk32 /home/enshrouded/.steam/sdk64 /home/enshrouded/.config/protonfixes /home/enshrouded/.cache/protonfixes \
    && groupadd -g "${PGID:-4711}" -o enshrouded \
    && useradd -g "${PGID:-4711}" -u "${PUID:-4711}" -o --create-home enshrouded \
    && ln -f /root/.steam/sdk32/steamclient.so /home/enshrouded/.steam/sdk32/steamclient.so \
    && ln -f /root/.steam/sdk64/steamclient.so /home/enshrouded/.steam/sdk64/steamclient.so \
    && sed -i '/imklog/s/^/#/' /etc/rsyslog.conf \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=builder /tmp/proton /usr/local/bin
COPY --from=builder /etc/machine-id /etc/machine-id

# Both Proton and the native Steam client must support the game's interface.
RUN python3 -c 'from pathlib import Path; \
    assert all(b"SteamUtils011" in Path(p).read_bytes() for p in ( \
        "/usr/local/bin/files/lib/wine/x86_64-unix/lsteamclient.so", \
        "/home/enshrouded/.steam/sdk64/steamclient.so")), "missing SteamUtils011"'

COPY ../supervisord.conf /etc/supervisor/supervisord.conf
COPY --chmod=755 ../scripts/default/* ../scripts/proton/* /usr/local/etc/enshrouded/

WORKDIR /usr/local/etc/enshrouded
CMD ["/usr/local/etc/enshrouded/bootstrap"]
ENTRYPOINT []
