FROM steamcmd/steamcmd:ubuntu-24@sha256:b879dff0485215889bc3409d3166873694c86d3d95445aa3dc8262d53d8a252d
LABEL maintainer="docker@mornedhels.de"

# Install prerequisites
RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        curl \
        supervisor \
        cron \
        rsyslog \
        jq \
        zip \
        python3 \
        python3-pip \
    && apt autoremove --purge && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install wine
ARG WINE_BRANCH=stable
RUN dpkg --add-architecture i386 \
    && mkdir -pm755 /etc/apt/keyrings \
    && curl -o /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && curl -O --output-dir /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$(grep VERSION_CODENAME= /etc/os-release | cut -d= -f2)/winehq-$(grep VERSION_CODENAME= /etc/os-release | cut -d= -f2).sources \
    && apt update && DEBIAN_FRONTEND="noninteractive" apt -y --install-recommends install wine-${WINE_BRANCH} \
    && apt autoremove --purge && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install winetricks (unused)
RUN curl -o /tmp/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
    && chmod +x /tmp/winetricks && install -m 755 /tmp/winetricks /usr/local/bin/winetricks \
    && rm -rf /tmp/*

# MISC
RUN mkdir -p /usr/local/etc /var/log/supervisor /var/run/enshrouded /usr/local/etc/supervisor/conf.d/ /opt/enshrouded /home/enshrouded/.steam \
    && groupadd -g "${PGID:-4711}" -o enshrouded \
    && useradd -g "${PGID:-4711}" -u "${PUID:-4711}" -o --create-home enshrouded \
    && sed -i '/imklog/s/^/#/' /etc/rsyslog.conf \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ../supervisord.conf /etc/supervisor/supervisord.conf
COPY --chmod=755 ../scripts/default/* ../scripts/wine/* /usr/local/etc/enshrouded/

WORKDIR /usr/local/etc/enshrouded
CMD ["/usr/local/etc/enshrouded/bootstrap"]
ENTRYPOINT []
