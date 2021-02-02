# um3-wooter
woots about new ultimaker 3 printjobs in a slack channel

The docker container compiles the go program and schedules it to run every 5 minutes (via cronjob).


## .env file
a .env file must be created in the root of this repo that stores the environmental variables.
> SLACK_HOOK=https://< url to slack hook >

> SLACK_HOOK_ALL=https://< url to slack channel that gets all messages >

> UM3_URI=https://< url to ultimaker api>/um3/print_job

## How to start
Build the docker container
> docker-compose build

Stand up the docker container
> docker-compose up