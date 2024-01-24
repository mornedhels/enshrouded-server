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

| Variable              | Required | Default             | Contraints | Description                                                                                                                  | WIP | 
|-----------------------|:--------:|---------------------|------------|------------------------------------------------------------------------------------------------------------------------------|:---:|
| `SERVER_NAME`         |          | `Enshrouded Server` |            | The name of the server                                                                                                       |  ️  |
| `SERVER_PASSWORD`     |          |                     |            | The password for the server                                                                                                  |     |
| `SERVER_SLOT_COUNT`   |          | `16`                | 1-16       | Max allowed players                                                                                                          |     |
| `SERVER_PORT`         |          | `15636`             |            | The game port for the server                                                                                                 |     |
| `SERVER_QUERYPORT`    |          | `15637`             |            | The steam query port for the server                                                                                          |     |
| `SERVER_IP`           |          | `0.0.0.0`           |            | Server IP for internal network configuration                                                                                 |     |
| `SERVER_SAVE_DIR`     |          | `./savegame`        |            | Folder for savegames (relative and absolute paths are supported)                                                             |     |
| `SERVER_LOG_DIR`      |          | `./logs`            |            | Folder for logs (relative and absolute paths are supported)                                                                  |     |
| `PUID`                |          | `4711`              |            | The UID to run server as (file permission)                                                                                   |     |
| `PGID`                |          | `4711`              |            | The GID to run server as (file permission)                                                                                   |     |
| `UPDATE_CRON`         |          |                     |            | Update game server files cron (eg. `*/30 * * * *` check for updates every 30 minutes)                                        |     |
| `STEAM_API_PUBLIC_IP` |          |                     |            | Server IP for the server empty check                                                                                         |     |
| `STEAM_API_KEY`       |          |                     |            | SteamApi key to authorize requests (needed for empty server check). Server restarts regardless of occupancy, if not provided |     |
| `GAME_BRANCH`         |          | `public`            |            | Steam branch (eg. testing) of the Enshrouded server                                                                          |     |
| `STEAMCMD_ARGS`       |          | `validate`          |            | Additional steamcmd args for the updater                                                                                     |     |

⚠️: Work in Progress

### Additional Information

* STEAM_API_KEY is only needed for the update cron, to check if the server is empty. You can get a key from
  [Steam](https://steamcommunity.com/dev/apikey). If not supplied, the check will be skipped.

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

[Official Docs](https://enshrouded.zendesk.com/hc/en-us/articles/16055628734109-Recommended-Server-Specifications)

* **CPU:** TBD
* **RAM:** TBD
* **Disk:** TBD
* **Docker Host:** TBD

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
  docker compose exec enshrouded supervisorctl start force-update
  ```

## Known Issues

No known issues so far.
