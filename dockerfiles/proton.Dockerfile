FROM steamcmd/steamcmd:ubuntu-24@sha256:db7aae37c1e502e5cc715d018e6ef4ec3c6d8d6d6208a8c5fd6eed8074f08eac AS builder

ARG GE_PROTON_VERSION="10-25"

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
RUN curl -sLOJ "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton${GE_PROTON_VERSION}/GE-Proton${GE_PROTON_VERSION}.tar.gz" \
    && mkdir -p /tmp/proton \
    && tar -xzf GE-Proton*.tar.gz -C /tmp/proton --strip-components=1 \
    && rm GE-Proton*.* \
    && rm -f /etc/machine-id \
    && dbus-uuidgen --ensure=/etc/machine-id


FROM steamcmd/steamcmd:ubuntu-24@sha256:db7aae37c1e502e5cc715d018e6ef4ec3c6d8d6d6208a8c5fd6eed8074f08eac
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
    && apt autoremove --purge && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install winetricks (unused)
RUN curl -o /tmp/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
    && chmod +x /tmp/winetricks && install -m 755 /tmp/winetricks /usr/local/bin/winetricks \
    && rm -rf /tmp/*

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

COPY ../supervisord.conf /etc/supervisor/supervisord.conf
COPY --chmod=755 ../scripts/default/* ../scripts/proton/* /usr/local/etc/enshrouded/

WORKDIR /usr/local/etc/enshrouded
CMD ["/usr/local/etc/enshrouded/bootstrap"]
ENTRYPOINT []
