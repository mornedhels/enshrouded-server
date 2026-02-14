# Security Hardening

To run the Enshrouded server more securely, you can apply several Docker security features. 

## Docker Compose Example

This example shows how to apply security hardening to your Enshrouded server container.

```yaml
services:
  enshrouded:
    image: mornedhels/enshrouded-server:latest
    container_name: enshrouded
    hostname: enshrouded
    # Security hardening: Prevent the container from gaining new privileges
    security_opt:
      - no-new-privileges=true
    # Drop all default capabilities and only add what's absolutely necessary
    cap_drop:
      - ALL
    cap_add:
      - DAC_OVERRIDE
      - CHOWN
      - SETUID
      - SETGID
      - KILL
    restart: unless-stopped
    stop_grace_period: 90s
    ports:
      - "15637:15637/udp"
    volumes:
      - ./game:/opt/enshrouded
    environment:
      - SERVER_NAME=Enshrouded Server
      - UPDATE_CRON=*/30 * * * *
      - PUID=4711
      - PGID=4711
```

## Security Measures Explained

### 1. Drop Capabilities (`cap_drop: - ALL`)
By default, Docker containers run with a subset of Linux capabilities. Dropping all of them (`ALL`) and only adding back what is strictly required (`cap_add`) significantly reduces the attack surface.

The required capabilities for this image are:
- `DAC_OVERRIDE`: Allows the container to bypass file read, write, and execute permission checks. Required for initialization and file management.
- `CHOWN`: Necessary for setting correct ownership of files (e.g., when using `PUID`/`PGID`).
- `SETUID`/`SETGID`: Required to switch to the non-root user that runs the server process.
- `KILL`: Needed for `supervisord` to manage and stop processes correctly.

### 2. No New Privileges (`no-new-privileges=true`)
This security option prevents processes inside the container from gaining additional privileges via `setuid` or `setgid` binaries.
