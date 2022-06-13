define HELP_MSG
Usage: $$ make COMMAND

COMMAND:
    start:
        Deploy the gitea service to the swarm.
        Delete any instances of the service if found.
    stop:
        Stop the service.
    ps, ls, logs_db, logs_server:
        Shortcuts to $$ docker service <subcommand>
    help:
        Shows this message.
endef

export HELP_MSG

help:
	@echo "$$HELP_MSG"

start:
	./stop
	./start

stop:
	./stop

ps:
	./ps

ls:
	./ls

logs_db:
	./logs_db

logs_server:
	./logs_server

.PHONY: help start stop ps ls logs_db logs_server
