# HackRVA-docker-infrastructure
Various Dockerfiles and configuration files to allow restoring HackRVA's non-vital infrastructure quickly when necessary

# infrastructure overview
The HackRVA docker infrastructure is built around docker-compose with several containers.

If working with this infrastructure, it's best to be familiar with docker-compose, Dockerfiles, and Docker in general.

To just get the infrastructure up and running, these two commands should be sufficient when run on the host machine as the dockergod user in /home/dockergod/HackRVA-docker-infrastructure

docker-compose build
docker-compose up

The configuration for this whole system is kept under version control to ideally allow for quick restoration of service in case of failures or when migration to a new server is desired.

gateway
===
This is the most important container as every other container connects to the outside world through this container. This container also handles tls encryption through certbot before passing https connections onward.

A new container can be connected to this one by adding an Apache configuration to Proxy to that container using the name for that container specified in docker-compose.yml as the hostname of that container. Cribbing connection configuration from existing files is probably good enough if you just want to get going fast.

database
===
This container hosts a mariadb database that is primarily used for keeping the HackRVA wiki's data. The actual data store is kept in a volume mounted from the host machine.

wiki
===
This container hosts the HackRVA wiki. The image store for the wiki is mounted from a volume to allow easier backups.

games
===
This container hosts games.hackrva.org

chat
===
This container hosts the HackRVA Rocket Chat.

