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

| Variable                                             | Required | Default             | Contraints            | Description                                                                                                        | WIP | 
|------------------------------------------------------|:--------:|---------------------|-----------------------|--------------------------------------------------------------------------------------------------------------------|:---:|
| `SERVER_NAME`                                        |          | `Enshrouded Server` | string                | The name of the server                                                                                             |  ️  |
| `SERVER_PASSWORD`                                    |          |                     | string                | The password for the server                                                                                        |     |
| `SERVER_SLOT_COUNT`                                  |          | `16`                | integer (1-16)        | Max allowed concurrent players                                                                                     |     |
| `SERVER_QUERYPORT`                                   |          | `15637`             | integer               | The steam query port for the server                                                                                |     |
| `SERVER_IP`                                          |          | `0.0.0.0`           | string (ipv4)         | Server IP for internal network configuration                                                                       |     |
| `SERVER_SAVE_DIR`                                    |          | `./savegame`        | string                | Folder for savegames (relative and absolute paths are supported)                                                   |     |
| `SERVER_LOG_DIR`                                     |          | `./logs`            | string                | Folder for logs (relative and absolute paths are supported)                                                        |     |
| `PUID`                                               |          | `4711`              | integer               | The UID to run server as (file permission)                                                                         |     |
| `PGID`                                               |          | `4711`              | integer               | The GID to run server as (file permission)                                                                         |     |
| `UPDATE_CRON`                                        |          |                     | string (cron format)  | Update game server files cron (eg. `*/30 * * * *` check for updates every 30 minutes)                              |     |
| `UPDATE_CHECK_PLAYERS`                               |          | `false`             | boolean (true, false) | Should the update check if someone is connected                                                                    |     |
| `BACKUP_CRON`                                        |          |                     | string (cron format)  | Backup game server files cron (eg. `*/15 * * * *` backup saves every 15 minutes) - don't set cron under 10 minutes |     |
| `BACKUP_DIR`                                         |          | `./backup`          | string                | Folder for backups (relative and absolute paths are supported)                                                     |     |
| `BACKUP_MAX_COUNT`                                   |          | `0`                 | integer               | Number of backups to keep (0 means infinite)                                                                       |     |
| `GAME_BRANCH`                                        |          | `public`            | string                | Steam branch (eg. testing) of the Enshrouded server                                                                |     |
| `STEAMCMD_ARGS`                                      |          | `validate`          | string                | Additional steamcmd args for the updater                                                                           |     |
| **[Server Roles](./docs/SERVER_ROLES.md)**           |          |                     |                       | further informations can be found following the link                                                               |     |
| **[Server Difficulty](./docs/SERVER_DIFFICULTY.md)** |          |                     |                       | further informations can be found following the link                                                               | ⚠️  |

All environment Variables prefixed with SERVER, are the available enshrouded_server.json options
(see [Enshrouded Docs](https://enshrouded.zendesk.com/hc/en-us/articles/16055441447709-Dedicated-Server-Configuration))

⚠️: Work in Progress

### Additional Information

* During the update process, the container temporarily requires more disk space (up to 2x the game size).
* Server role configuration can be done via the `enshrouded_server.json` file directly or the `SERVER_ROLE_<index>_XYZ`
  environment vars. The file is located in the `game/server` folder. More information can be found in
  the [official documentation](https://enshrouded.zendesk.com/hc/en-us/articles/19191581489309-Server-Roles-Configuration).

### Hooks

| Variable           | Description                            | WIP |
|--------------------|----------------------------------------|:---:|
| `BOOTSTRAP_HOOK`   | Command to run after general bootstrap |     |
| `UPDATE_PRE_HOOK`  | Command to run before update           |     |
| `UPDATE_POST_HOOK` | Command to run after update            |     |
| `BACKUP_PRE_HOOK`  | Command to run before backup & cleanup |     |
| `BACKUP_POST_HOOK` | Command to run after backup & cleanup  |     |

The scripts will wait for the hook to resolve/return before continuing.

⚠️: Work in Progress

## Image Tags

| Tag                | Virtualization | Description                              |
|--------------------|----------------|------------------------------------------|
| `latest`           | proton         | Latest image based on proton             |
| `<version>`        | proton         | Pinned image based on proton (>= 1.x.x)  |
| `stable-proton`    | proton         | Same as latest image                     |
| `<version>-proton` | proton         | Pinned image based on proton             |
| `stable-wine`      | wine           | Latest image based on wine               |
| `<version>-wine`   | wine           | Pinned image based on wine               |
| `dev-proton`       | proton         | Dev build based on proton                |
| `dev-wine`         | wine           | Dev build based on wine                  |
| `dev-wine-staging` | wine           | Dev build based on wine (staging branch) |

## Ports (default)

| Port      | Description      |
|-----------|------------------|
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
  -p 15637:15637/udp \
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
services:
  enshrouded:
    image: mornedhels/enshrouded-server:latest
    container_name: enshrouded
    hostname: enshrouded
    restart: unless-stopped
    stop_grace_period: 90s
    ports:
      - "15637:15637/udp"
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
services:
  enshrouded:
    image: mornedhels/enshrouded-server:latest
    container_name: enshrouded
    hostname: enshrouded
    restart: unless-stopped
    stop_grace_period: 90s
    ports:
      - "15637:15637/udp"
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

## Backup

The image includes a backup script that creates a zip file of the last saved game state. To enable backups, set
the `BACKUP_CRON` environment variable. To limit the number of backups, set the `BACKUP_MAX_COUNT` environment variable.

To restore a backup, stop the server and simply extract the zip file to the savegame folder and start the server up
again. If you want to keep the current savegame, make sure to make a backup before deleting or overwriting the files.

> [!WARNING]  
> Verify the permissions of the extracted files. The files should be owned by the user with the UID and GID set in the
> environment variables. If the image is running in privileged mode, the files will be automatically chowned to the
> given `UID` and `GID`.

## Commands

* **Force Update:**
  ```bash
  docker compose exec enshrouded supervisorctl start enshrouded-force-update
  ```
* **Reset Server Roles:** (Restarts the whole docker container) ⚠️
  ```bash
  docker compose exec enshrouded supervisorctl start enshrouded-reset-roles
  ```

## Known Issues

* The server doesn't start (not logging `'HostOnline' (up)!`) or the update fails with following error:
  ```
  Error! App '2278520' state is 0x202 after update job.
  ```
  This means there is probably something wrong with your file permissions. Make sure the UID and GID are correct and the
  files are owned by the correct user.
