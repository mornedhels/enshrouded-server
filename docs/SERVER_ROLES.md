# [Server Roles](https://enshrouded.zendesk.com/hc/en-us/articles/19191581489309-Server-Roles-Configuration)

To configure server roles, you can use the `SERVER_ROLE_<index>_` environment variables. The index starts at 0. It will
find the corresponding role in the `enshrouded_server.json` file and update the values accordingly.
You can also just edit the `enshrouded_server.json` file directly.

## Environment Variables

| Variable                   | Default   | Contraints            | Description                                                                     | WIP | 
|----------------------------|-----------|-----------------------|---------------------------------------------------------------------------------|:---:|
| **Server Roles**           |           |                       | prefix with `SERVER_ROLE_<index>_` e.g. `SERVER_ROLE_0_NAME` (alias usergroups) |     |
|   `NAME`                   | `Default` | string                | The name of the server role on index (starting with 0)                          |     |
|   `PASSWORD`               | `""`      | string                | The password for the server role                                                |     |
|   `CAN_KICK_BAN`           | `false`   | boolean (true, false) | Permission to kick and ban players                                              |     |
|   `CAN_ACCESS_INVENTORIES` | `false`   | boolean (true, false) | Permission to access inventories                                                |     |
|   `CAN_EDIT_WORLD`         | `false`   | boolean (true, false) | Permission to edit world structures                                             | ⚠️  |
|   `CAN_EDIT_BASE`          | `false`   | boolean (true, false) | Permission to edit the base                                                     |     |
|   `CAN_EXTEND_BASE`        | `false`   | boolean (true, false) | Permission to extend the base                                                   |     |
|   `RESERVED_SLOTS`         | `0`       | integer               | Number of reserved slots for the server role                                    |     |

## Example Usage

<details><summary>Expand</summary>

With environment variables:

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
      - SERVER_ROLE_0_NAME=Admins
      - SERVER_ROLE_0_PASSWORD=secret1
      - SERVER_ROLE_0_CAN_KICK_BAN=true
      - SERVER_ROLE_0_CAN_ACCESS_INVENTORIES=true
      - SERVER_ROLE_0_CAN_EDIT_WORLD=true
      - SERVER_ROLE_0_CAN_EDIT_BASE=true
      - SERVER_ROLE_0_CAN_EXTEND_BASE=true
      - SERVER_ROLE_0_RESERVED_SLOTS=1
      - SERVER_ROLE_1_NAME=Friends
      - SERVER_ROLE_1_PASSWORD=secret2
      - SERVER_ROLE_1_CAN_ACCESS_INVENTORIES=true
      - SERVER_ROLE_1_CAN_EDIT_WORLD=true
      - SERVER_ROLE_1_CAN_EDIT_BASE=true
      - SERVER_ROLE_1_CAN_EXTEND_BASE=true
      - SERVER_ROLE_1_RESERVED_SLOTS=3
      - SERVER_ROLE_2_NAME=Guests
      - SERVER_ROLE_2_PASSWORD=secret3
```

Creates the following `enshrouded_server.json` file:

```json
{
  "name": "Enshrouded Server",
  "password": "",
  "saveDirectory": "./savegame",
  "logDirectory": "./logs",
  "ip": "0.0.0.0",
  "queryPort": 15637,
  "slotCount": 16,
  "userGroups": [
    {
      "name": "Admins",
      "password": "secret1",
      "canKickBan": true,
      "canAccessInventories": true,
      "canEditWorld": true,
      "canEditBase": true,
      "canExtendBase": true,
      "reservedSlots": 1
    },
    {
      "name": "Friends",
      "password": "secret2",
      "canKickBan": false,
      "canAccessInventories": true,
      "canEditWorld": true,
      "canEditBase": true,
      "canExtendBase": true,
      "reservedSlots": 3
    },
    {
      "name": "Guests",
      "password": "secret3",
      "canKickBan": false,
      "canAccessInventories": false,
      "canEditWorld": false,
      "canEditBase": false,
      "canExtendBase": false,
      "reservedSlots": 0
    }
  ]
}
```

</details>
