# node-template

Simple local workflow for starting, stopping, and debugging the application.

## Start the application

```bash
make up
```

This command builds the base image if needed and starts the API container.

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

- Open a shell inside the database container:

  ```bash
  make db
  ```

