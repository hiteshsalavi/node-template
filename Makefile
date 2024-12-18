root_user = mutagen-compose exec api
app_user_run = $(root_user) /sbin/setuser app

build-base:
	@bin/build-base

up-detached:
	$(MAKE) build-base
	# mutagen-compose up -d db
	# $(MAKE) _wait-for-db
	mutagen-compose up -d api
	# $(MAKE) _wait-for-api

up:
	$(MAKE) up-detached
	$(MAKE) api-logs

logs:
	mutagen-compose logs --follow --tail=1000

api-logs:
	mutagen-compose logs --follow --tail=1000 api

down:
	mutagen-compose stop api

passenger-status: _require-api-up
	$(app_user_run) passenger-status

restart:
	$(root_user) sv stop app
	$(root_user) sv start app

# Wait for the database to be up, as visible from inside the container not the host.
_wait-for-db:
	@mutagen-compose run api bash -c "until nc -z db 3306; do echo 'Waiting for db instance to start...' && sleep 1; done"
	@echo Waiting for db instance to start...

_wait-for-api:
	@mutagen-compose exec api bin/wait-on-api.sh

# Refrain using `mutagen-compose run`. `run` overrides the Dockerfile entrypoint and only runs one process.
_require-api-up:
	@mutagen-compose exec api echo "Let's get started!" || (echo '\nERROR: Run "make up" first.' && exit -1)