# node-template

Simple web app with phusion passenger and nginx and built on TypeScript

It uses `nodejs/v22.22.0` and `npm/11.8.0`.

## Dependencies
- Docker, Mutagen Compose

## Volumes are bounded
- Once `make up` has created the api container, `node_modules` is also mounted on the host system. This makes it possible to run `npm run build` and other commands that require npm libraries on the host.

## Start the application

```bash
make up
```

This command builds the base image if needed and starts the API container in detached mode and starts logging.

Once started some basic, `GET localhost:3000/api/healthcheck` and `GET localhost:3000/error-endpoint` endpoints are available.

## Stop the application

```bash
make down
```

## Debug and inspect the running services

- Open a shell inside the running API container:

  ```bash
  make exec-api
  ```

- Show Passenger status inside the API container:

  ```bash
  make passenger-status
  ```
  <img width="702" height="519" alt="Screenshot 2026-04-15 at 11 48 07 pm" src="https://github.com/user-attachments/assets/62ed6723-a242-4ec5-aebb-54da441a5eac" />

- Open a shell inside the running DB container

  ```bash
  make db
  ```

## Development and Production environment commands

- Restart the app service running in container:

  ```bash
  make restart
  ```

- Rebuild the app and restart the service:

  ```bash
  make dev-restart
  ```
