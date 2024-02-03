FROM steamcmd/steamcmd:ubuntu-22@sha256:aacb177822e1fff35aec7f1bb7908571e70e29b4cdddaa419bb03061f6aafd3a
LABEL maintainer="docker@mornedhels.de"

# Install prerequisites
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        cabextract \
        curl \
        winbind \
        supervisor \
        cron \
        rsyslog \
        jq \
        lsof \
        zip \
        tar \
        dbus \
        libfreetype6 \
        libfreetype6:i386 \
        gnutls-bin

# Install winetricks (unused)
RUN curl -o /tmp/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
    && chmod +x /tmp/winetricks && install -m 755 /tmp/winetricks /usr/local/bin/winetricks

# install proton
RUN curl -sLOJ "$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep browser_download_url | cut -d\" -f4 | grep .tar.gz)" \
    && tar -xzf GE-Proton*.tar.gz -C /usr/local/bin/ --strip-components=1 \
    && rm GE-Proton*.* \
    && rm -f /etc/machine-id \
    && dbus-uuidgen --ensure=/etc/machine-id

# MISC
RUN mkdir -p /usr/local/etc /var/log/supervisor /var/run/enshrouded /usr/local/etc/supervisor/conf.d/ /opt/enshrouded /home/enshrouded/.steam/sdk32 /home/enshrouded/.steam/sdk64 \
    && groupadd -g "${PGID:-4711}" -o enshrouded \
    && useradd -g "${PGID:-4711}" -u "${PUID:-4711}" -o --create-home enshrouded \
    && ln -f /root/.steam/sdk32/steamclient.so /home/enshrouded/.steam/sdk32/steamclient.so \
    && ln -f /root/.steam/sdk64/steamclient.so /home/enshrouded/.steam/sdk64/steamclient.so \
    && sed -i '/imklog/s/^/#/' /etc/rsyslog.conf \
    && apt autoremove --purge && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ../supervisord.conf /etc/supervisor/supervisord.conf
COPY --chmod=755 ../scripts/default/* ../scripts/proton/* /usr/local/etc/enshrouded/

WORKDIR /usr/local/etc/enshrouded
CMD ["/usr/local/etc/enshrouded/bootstrap"]
ENTRYPOINT []
