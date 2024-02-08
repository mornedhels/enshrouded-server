# Enshrouded-Dedicated-Server

[![Docker Pulls](https://img.shields.io/docker/pulls/mornedhels/enshrouded-server.svg)](https://hub.docker.com/r/mornedhels/enshrouded-server)
[![Docker Stars](https://img.shields.io/docker/stars/mornedhels/enshrouded-server.svg)](https://hub.docker.com/r/mornedhels/enshrouded-server)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/mornedhels/enshrouded-server/latest)](https://hub.docker.com/r/mornedhels/enshrouded-server)
[![GitHub](https://img.shields.io/github/license/mornedhels/enshrouded-server)](https://github.com/mornedhels/enshrouded-server/blob/main/LICENSE)

[![GitHub](https://img.shields.io/badge/Repository-mornedhels/enshrouded--server-blue?logo=github)](https://github.com/mornedhels/enshrouded-server)

Docker image for the game Enshrouded. The image is based on
the [steamcmd](https://hub.docker.com/r/cm2network/steamcmd/) image and uses supervisor to handle startup, automatic
updates and cleanup.

## Environment Variables

| Variable               | Required | Default             | Contraints            | Description                                                                                                        | WIP | 
|------------------------|:--------:|---------------------|-----------------------|--------------------------------------------------------------------------------------------------------------------|:---:|
| `SERVER_NAME`          |          | `Enshrouded Server` | string                | The name of the server                                                                                             |  ️  |
| `SERVER_PASSWORD`      |          |                     | string                | The password for the server                                                                                        |     |
| `SERVER_SLOT_COUNT`    |          | `16`                | integer (1-16)        | Max allowed concurrent players                                                                                     |     |
| `SERVER_PORT`          |          | `15636`             | integer               | The game port for the server                                                                                       |     |
| `SERVER_QUERYPORT`     |          | `15637`             | integer               | The steam query port for the server                                                                                |     |
| `SERVER_IP`            |          | `0.0.0.0`           | string (ipv4)         | Server IP for internal network configuration                                                                       |     |
| `SERVER_SAVE_DIR`      |          | `./savegame`        | string                | Folder for savegames (relative and absolute paths are supported)                                                   |     |
| `SERVER_LOG_DIR`       |          | `./logs`            | string                | Folder for logs (relative and absolute paths are supported)                                                        |     |
| `PUID`                 |          | `4711`              | integer               | The UID to run server as (file permission)                                                                         |     |
| `PGID`                 |          | `4711`              | integer               | The GID to run server as (file permission)                                                                         |     |
| `UPDATE_CRON`          |          |                     | string (cron format)  | Update game server files cron (eg. `*/30 * * * *` check for updates every 30 minutes)                              |     |
| `UPDATE_CHECK_PLAYERS` |          | `false`             | boolean (true, false) | Should the update check if someone is connected                                                                    |     |
| `BACKUP_CRON`          |          |                     | string (cron format)  | Backup game server files cron (eg. `*/15 * * * *` backup saves every 15 minutes) - don't set cron under 10 minutes |     |
| `BACKUP_DIR`           |          | `./backup`          | string                | Folder for backups (relative and absolute paths are supported)                                                     |     |
| `BACKUP_MAX_COUNT`     |          | `0`                 | integer               | Number of backups to keep (0 means infinite)                                                                       |     |
| `GAME_BRANCH`          |          | `public`            | string                | Steam branch (eg. testing) of the Enshrouded server                                                                |     |
| `STEAMCMD_ARGS`        |          | `validate`          | string                | Additional steamcmd args for the updater                                                                           |     |

All environment Variables prefixed with SERVER, are the available enshrouded_server.json options 
(see [Enshrouded Docs](https://enshrouded.zendesk.com/hc/en-us/articles/16055441447709-Dedicated-Server-Configuration))

⚠️: Work in Progress

### Additional Information

* During the update process, the container temporarily requires more disk space (up to 2x the game size).

### Hooks

| Variable           | Description                            | WIP |
|--------------------|----------------------------------------|:---:|
| `BOOTSTRAP_HOOK`   | Command to run after general bootstrap | ⚠️  |
| `UPDATE_POST_HOOK` | Command to run after update            | ⚠️  |

The scripts will wait for the hook to resolve/return before continuing.

⚠️: Work in Progress

## Image Tags

| Tag                | Virtualization | Description                  |
|--------------------|----------------|------------------------------|
| `latest`           | wine           | Latest image based on wine   |
| `stable-wine`      | wine           | Same as latest image         |
| `<version>-wine`   | wine           | Pinned image based on wine   |
| `stable-proton`    | proton         | Latest image based on proton |
| `<version>-proton` | proton         | Pinned image based on proton |
| `dev`              | wine           | Dev build based on wine      |
| `dev-proton`       | proton         | Dev build based on proton    |

## Ports (default)

| Port      | Description      |
|-----------|------------------|
| 15636/udp | Game port        |
| 15637/udp | Steam query port |

## Volumes

| Volume          | Description                      |
|-----------------|----------------------------------|
| /opt/enshrouded | Game files (steam download path) |

**Note:** By default the volumes are created with the UID and GID 4711 (that user should not exist). To change this, set
the environment variables `PUID` and `PGID`.

## Recommended System Requirements

* CPU: >= 6 cores
* RAM: >= 16 GB
* Disk: >= 30 GB (preferably SSD)

**[Official Docs](https://enshrouded.zendesk.com/hc/en-us/articles/16055628734109-Recommended-Server-Specifications)**

## Usage

### Docker

```bash
docker run -d --name enshrouded \
  --hostname enshrouded \
  --restart=unless-stopped \
  -p 15636-15637:15636-15637/udp \
  -v ./game:/opt/enshrouded \
  -e SERVER_NAME="Enshrouded Server" \
  -e SERVER_PASSWORD="secret" \
  -e UPDATE_CRON="*/30 * * * *" \
  -e PUID=4711 \
  -e PGID=4711 \
  mornedhels/enshrouded-server:latest
```

### Docker Compose

```yaml
version: "3"
services:
  enshrouded:
    image: mornedhels/enshrouded-server:latest
    container_name: enshrouded
    hostname: enshrouded
    restart: unless-stopped
    stop_grace_period: 90s
    ports:
      - "15636-15637:15636-15637/udp"
    volumes:
      - ./game:/opt/enshrouded
    environment:
      - SERVER_NAME=Enshrouded Server
      - SERVER_PASSWORD=secret
      - UPDATE_CRON=*/30 * * * *
      - PUID=4711
      - PGID=4711
```

**Note:** The volumes are created next to the docker-compose.yml file. If you want to create the volumes, in the default
location (eg. /var/lib/docker) you can use the following compose file:

```yaml
version: "3"
services:
  enshrouded:
    image: mornedhels/enshrouded-server:latest
    container_name: enshrouded
    hostname: enshrouded
    restart: unless-stopped
    stop_grace_period: 90s
    ports:
      - "15636-15637:15636-15637/udp"
    volumes:
      - game:/opt/enshrouded
    environment:
      - SERVER_NAME=Enshrouded Server
      - SERVER_PASSWORD=secret
      - UPDATE_CRON=*/30 * * * *
      - PUID=4711
      - PGID=4711

volumes:
  game:
```

## Commands

* **Force Update:**
  ```bash
  docker compose exec enshrouded supervisorctl start enshrouded-force-update
  ```

## Known Issues

* The server doesn't start (not logging `'HostOnline' (up)!`) or the update fails with following error:
  ```
  Error! App '2278520' state is 0x202 after update job.
  ```
  This means there is probably something wrong with your file permissions. Make sure the UID and GID are correct and the
  files are owned by the correct user.
