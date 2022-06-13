# gitea_docker_swarm

Gitea is a community managed lightweight code hosting solution written in Go.
It is published under the [MIT license](https://choosealicense.com/licenses/mit/).
[Gitea](https://gitea.io/en-us/) setup for running in a [docker swarm](https://docs.docker.com/engine/swarm/).

[Για Ελληνικά δείτε το README](README.md)

## Configuration

Gitea's config resides in
`./gitea/gitea/conf/app.ini`.
In here someone defines important values such as
base url, ssh url.
The file is created after the first run.
More information on the options offered by the config file 
can be found in [gitea's documentation](https://docs.gitea.io/en-us/config-cheat-sheet/).

## Start Service

The service starts by running the command `make start`.

## Stop Service

The service stops by running the command `make stop`.

## Setting up ssh container passthrough

For setting up ssh container passthrough run `make setup_ssh`.

You will be asked for your root credentials in order to create
the `git` user on your host machine.
