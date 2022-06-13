# gitea_docker_swarm ΕΛ

Το gitea_docker_swarm παρέχει τα απαραίτητα αρχεία και οδηγίες
ώστε να τρέξει κάποιος τον git server gitea σε docker swarm
(με την προϋπόθεση ότι υπάρχει ήδη ένα δίκτυο swarm).

## Εκκίνηση Υπηρεσίας

Η υπηρεσία ξεκινάει με την εντολή `make start`.

## Παύση Υπηρεσίας

Η υπηρεσία σταματάει με την εντολή `make stop`.

## Ρύθμιση ssh container passthrough

Για τη ρύθμιση του ssh container passthrough εκτελέστε `make setup_ssh`.

# gitea_docker_swarm EN

Gitea setup for running in a docker swarm.

## Start Service

The service starts by running the command `make start`.

## Stop Service

The service stops by running the command `make stop`.

## Setting up ssh container passthrough

For setting up ssh container passthrough run `make setup_ssh`.
