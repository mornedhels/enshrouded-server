# [Server Difficulty](https://enshrouded.zendesk.com/hc/en-us/articles/20453241249821-Server-Difficulty-Settings)

## Environment Variables

| Variable                                 | Default                | Contraints                                          | Description                                                                                                                                                                                     | WIP | 
|------------------------------------------|------------------------|-----------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---:|
| **Server Difficulty**                    |                        |                                                     | prefix with `SERVER_GS_` e.g. `SERVER_GS_PRESET` (alias gamesettings)                                                                                                                           |     |
|   `PRESET`                               | `Default`              | Default \| Relaxed \| Hard \| Survival \| Custom    | The difficulty preset for the server. Other settings only work with preset `Custom`                                                                                                             |     |
|   `PLAYER_HEALTH_FACTOR`                 | `1`                    | 0.25 - 4                                            | Scales the max health for players by a factor. Ingame, the factor is represented by a percentage                                                                                                |     |
|   `PLAYER_MANA_FACTOR`                   | `1`                    | 0.25 - 4                                            | Scales the max mana for players by a factor. Ingame, the factor is represented by a percentage                                                                                                  |     |
|   `PLAYER_STAMINA_FACTOR`                | `1`                    | 0.25 - 4                                            | Scales the max stamina for players by a factor. Ingame, the factor is represented by a percentage                                                                                               |     |
|   `PLAYER_BODY_HEAT_FACTOR`              | `1`                    | low: 0.5 \| default: 1 \| high: 1.5 \| max: 2       | Scales the max amount of available body heat in the player. The higher the factor the longer the player can stay in very cold areas before hypothermia sets in.                                 |     |
|   `ENABLE_DURABILITY`                    | `true`                 | boolean (true, false)                               | Whether weapon durability is enabled                                                                                                                                                            |     |
|   `ENABLE_STARVING_DEBUFF`               | `false`                | boolean (true, false)                               | Enables hunger and starvation. During starvation, the player loses health periodically until death if no food or drink is consumed                                                              |     |
|   `FOOD_BUFF_DURATION_FACTOR`            | `1`                    | 0.5 - 2                                             | Scales food buff durations. Ingame, the factor is represented by a percentage                                                                                                                   |     |
|   `FROM_HUNGER_TO_STARVING`              | `600000000000`         | 300000000000 - 1200000000000                        | This setting controls the length of the hungry state before the starving sets in. The unit in this setting is nanoseconds. Ingame the time is displayed in minutes                              |     |
|   `SHROUD_TIME_FACTOR`                   | `1`                    | 0.5 - 2                                             | Scales how long player characters can remain within the Shroud. Ingame, the factor is represented by a percentage                                                                               |     |
|   `ENABLE_GLIDER_TURBULENCES`            | `true`                 | boolean (true, false)                               | If turned off, the glider will not be affected by air turbulences, just as in previous versions of the game.                                                                                    |     |
|   `WEATHER_FREQUENCY`                    | `Normal`               | Disabled \| Rare \| Normal \| Often                 | This setting allows defining how often new weather phenomena appear in the game world.                                                                                                          |     |
|   `RANDOM_SPAWNER_AMOUNT`                | `Normal`               | Few \| Normal \| Many \| Extreme                    | This setting controls the amount of enemies in the world                                                                                                                                        |     |
|   `MINING_DAMAGE_FACTOR`                 | `1`                    | 0.5 - 2                                             | This scales the mining damage. A higher mining damage leads to increased terraforming and more yield of resources per hit. Ingame, the factor is represented by a percentage                    |     |
|   `PLANT_GROWTH_SPEED_FACTOR`            | `1`                    | 0.25 - 2                                            | Scales the value of the plant growth speed. Ingame, the factor is represented by a percentage                                                                                                   |     |
|   `RESOURCE_DROP_STACK_AMOUNT_FACTOR`    | `1`                    | 0.25 - 2                                            | Scales the amount of materials per loot stack in chests, defeated enemies etc. Ingame, the factor is represented by a percentage                                                                |     |
|   `FACTORY_PRODUCTION_SPEED_FACTOR`      | `1`                    | 0.25 - 2                                            | Scales the length of production times for workshop items. Ingame, the factor is represented by a percentage                                                                                     |     |
|   `PERK_UPGRADE_RECYCLING_FACTOR`        | `0.100000`             | 0 - 1                                               | Scales the amount of Runes that are returned to you when salvaging upgraded weapons. Ingame, the factor is represented by a percentage                                                          |     |
|   `PERK_COST_FACTOR`                     | `1`                    | 0.25 - 2                                            | Scales the amount of Runes required for upgrading weapons. Ingame, the factor is represented by a percentage                                                                                    |     |
|   `EXPERIENCE_COMBAT_FACTOR`             | `1`                    | 0.25 - 2                                            | Scales the amount of XP received through combat. Ingame, the factor is represented by a percentage                                                                                              |     |
|   `EXPERIENCE_MINING_FACTOR`             | `1`                    | 0`?` - 2                                            | Scales the amount of XP received by mining resources. Ingame, the factor is represented by a percentage                                                                                         |     |
|   `EXPERIENCE_EXPLORATION_QUESTS_FACTOR` | `1`                    | 0.25 - 2                                            | Scales the amount of XP received by exploring and completing quests. Ingame, the factor is represented by a percentage                                                                          |     |
|   `AGGRO_POOL_AMOUNT`                    | `Normal`               | Few \| Normal \| Many \| Extreme                    | This setting controls how many enemies are allowed to attack at the same time. Ingame, the factor is represented by a percentage                                                                |     |
|   `ENEMY_DAMAGE_FACTOR`                  | `1`                    | 0.25 - 5                                            | Scales all enemy damage by this value - except for bosses. Ingame, the factor is represented by a percentage                                                                                    |     |
|   `ENEMY_HEALTH_FACTOR`                  | `1`                    | 0.25 - 4                                            | Scales all enemy health by this value - except for bosses. Ingame, the factor is represented by a percentage                                                                                    |     |
|   `ENEMY_STAMINA_FACTOR`                 | `1`                    | 0.5 - 2                                             | Scales all enemy stamina by this value. It will take longer to stun enemies with a higher enemy stamina. This excludes bosses. Ingame, the factor is represented by a percentage                |     |
|   `ENEMY_PERCEPTION_RANGE_FACTOR`        | `1`                    | 0.5 - 2                                             | Scales how far enemies can see and hear the player. This excludes bosses. Ingame, the factor is represented by a percentage                                                                     |     |
|   `BOSS_DAMAGE_FACTOR`                   | `1`                    | 0.2 - 5                                             | This setting scales the damage of boss attacks. Ingame, the factor is represented by a percentage                                                                                               |     |
|   `BOSS_HEALTH_FACTOR`                   | `1`                    | 0.2 - 5                                             | Scales all health of bosses by this value. Ingame, the factor is represented by a percentage                                                                                                    |     |
|   `THREAT_BONUS`                         | `1`                    | 0.25 - 4                                            | Scales the frequency of enemy attacks. This excludes bosses. Ingame, the factor is represented by a percentage                                                                                  |     |
|   `PACIFY_ALL_ENEMIES`                   | `false`                | boolean (true, false)                               | If turned on, enemies won't attack the players until they are attacked. This excludes bosses                                                                                                    |     |
|   `TAMING_STARTLE_REPERCUSSION`          | `LoseSomeProgress`     | KeepProgress \| LoseSomeProgress \| LoseAllProgress | This setting allows defining how the game reacts when the player startles the wildlife during taming. Progress is visualized by hearts in the game.                                             |     |
|   `DAY_TIME_DURATION`                    | `1800000000000`        | 120000000000 - 3600000000000                        | Scales the length of daytime. A smaller value equals shorter daytime. The unit is nanoseconds. Ingame, the time is displayed in minutes                                                         |     |
|   `NIGHT_TIME_DURATION`                  | `720000000000`         | 120000000000 - 1800000000000                        | Scales the length of nighttime. A smaller value equals shorter nighttime. The unit is nanoseconds. Ingame, the time is displayed in minutes                                                     |     |
|   `TOMBSTONE_MODE`                       | `AddBackpackMaterials` | AddBackpackMaterials \| Everything \| NoTombstone   | The players can either keep or lose all items from their backpack when dying. In the default setting, they only lose materials. Lost items are stored in a tombstone and can be recovered there |     |
|   `CURSE_MODIFIER`                       | `Normal`               | Off \| Normal \| Hard                               | The chances of getting cursed by enemies. With hard, the chance is doubled. With off, the curse mechanic is disabled.                                                                           | ⚠️  |

⚠️: Work in Progress

> [!TIP]  
> The gameSettings config will be generated automatically with default values when you start the server without
> specifying any environment variables.
>
> You can also adjust the settings directly in the `enshrouded_server.json` file.

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
      - SERVER_ROLE_0_NAME=Default
      - SERVER_ROLE_0_PASSWORD=secret123
      - SERVER_GS_PRESET=Custom
      - SERVER_GS_PLAYER_HEALTH_FACTOR=2
      - SERVER_GS_PLAYER_MANA_FACTOR=2
      - SERVER_GS_PLAYER_STAMINA_FACTOR=2
      - SERVER_GS_PLAYER_BODY_HEAT_FACTOR=2
      - SERVER_GS_ENABLE_DURABILITY=true
      - SERVER_GS_ENABLE_STARVING_DEBUFF=false
      - SERVER_GS_FOOD_BUFF_DURATION_FACTOR=1
      - SERVER_GS_FROM_HUNGER_TO_STARVING=600000000000
      - SERVER_GS_SHROUD_TIME_FACTOR=1
      - SERVER_GS_ENABLE_GLIDER_TURBULENCES=false
      - SERVER_GS_WEATHER_FREQUENCY=Often
      - SERVER_GS_RANDOM_SPAWNER_AMOUNT=Normal
      - SERVER_GS_MINING_DAMAGE_FACTOR=1
      - SERVER_GS_PLANT_GROWTH_SPEED_FACTOR=1
      - SERVER_GS_RESOURCE_DROP_STACK_AMOUNT_FACTOR=1
      - SERVER_GS_FACTORY_PRODUCTION_SPEED_FACTOR=1
      - SERVER_GS_PERK_UPGRADE_RECYCLING_FACTOR=0.5
      - SERVER_GS_PERK_COST_FACTOR=1
      - SERVER_GS_EXPERIENCE_COMBAT_FACTOR=1
      - SERVER_GS_EXPERIENCE_MINING_FACTOR=1
      - SERVER_GS_EXPERIENCE_EXPLORATION_QUESTS_FACTOR=1
      - SERVER_GS_AGGRO_POOL_AMOUNT=Normal
      - SERVER_GS_ENEMY_DAMAGE_FACTOR=1
      - SERVER_GS_ENEMY_HEALTH_FACTOR=1
      - SERVER_GS_ENEMY_STAMINA_FACTOR=1
      - SERVER_GS_ENEMY_PERCEPTION_RANGE_FACTOR=1
      - SERVER_GS_BOSS_DAMAGE_FACTOR=1
      - SERVER_GS_BOSS_HEALTH_FACTOR=1
      - SERVER_GS_THREAT_BONUS=1
      - SERVER_GS_PACIFY_ALL_ENEMIES=false
      - SERVER_GS_TAMING_STARTLE_REPERCUSSION=LoseAllProgress
      - SERVER_GS_DAY_TIME_DURATION=1800000000000
      - SERVER_GS_NIGHT_TIME_DURATION=720000000000
      - SERVER_GS_TOMBSTONE_MODE=AddBackpackMaterials
      - SERVER_GS_CURSE_MODIFIER=Normal
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
      "name": "Custom",
      "password": "secret123",
      "canKickBan": false,
      "canAccessInventories": false,
      "canEditBase": false,
      "canExtendBase": false,
      "reservedSlots": 0
    }
  ],
  "gameSettingsPreset": "Custom",
  "gameSettings": {
    "playerHealthFactor": 2,
    "playerManaFactor": 2,
    "playerStaminaFactor": 2,
    "playerBodyHeatFactor": 2,
    "enableDurability": true,
    "enableStarvingDebuff": false,
    "foodBuffDurationFactor": 1,
    "fromHungerToStarving": 600000000000,
    "shroudTimeFactor": 1,
    "enableGliderTurbulences": false,
    "weatherFrequency": "Often",
    "randomSpawnerAmount": "Normal",
    "miningDamageFactor": 1,
    "plantGrowthSpeedFactor": 1,
    "resourceDropStackAmountFactor": 1,
    "factoryProductionSpeedFactor": 1,
    "perkUpgradeRecyclingFactor": 0.5,
    "perkCostFactor": 1,
    "experienceCombatFactor": 1,
    "experienceMiningFactor": 1,
    "experienceExplorationQuestsFactor": 1,
    "aggroPoolAmount": "Normal",
    "enemyDamageFactor": 1,
    "enemyHealthFactor": 1,
    "enemyStaminaFactor": 1,
    "enemyPerceptionRangeFactor": 1,
    "bossDamageFactor": 1,
    "bossHealthFactor": 1,
    "threatBonus": 1,
    "pacifyAllEnemies": false,
    "tamingStartleRepercussion": "LoseAllProgress",
    "dayTimeDuration": 1800000000000,
    "nightTimeDuration": 720000000000,
    "tombstoneMode": "AddBackpackMaterials",
    "curseModifier": "Normal"
  }
}
```

</details>
