define HELP_MSG
Usage: $$ make COMMAND

COMMAND:
    start:
        Deploy the gitea service to the swarm.
        Delete any instances of the service if found.
    stop:
        Stop the service.
    setup_ssh:
        Set up ssh container passthrough, for $$ git pushing using ssh.
    ps, ls, logs_db, logs_server:
        Shortcuts to $$ docker service <subcommand>
    help:
        Shows this message.
endef

export HELP_MSG

help:
	@echo "$$HELP_MSG"

start: stop
	@mkdir -p ./gitea
	@echo "Starting serice.."
	@docker stack deploy gitea --compose-file docker-compose.yml
	@echo "done"

stop:
	@echo "Stoppping service.."
	-@docker service rm gitea_db
	-@docker service rm gitea_server
	@echo "done"

ps:
	@docker service ps gitea_server
	@docker service ps gitea_db

ls:
	@docker service ls

logs_db:
	@docker service logs gitea_db

logs_server:
	@docker service logs gitea_server

setup_ssh:
	@echo "Setting up ssh container passthrough.."
	@./setup_ssh.sh
	@echo "done"

.PHONY: help start stop ps ls logs_db logs_server
