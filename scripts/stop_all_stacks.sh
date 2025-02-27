#!/bin/bash

STACKS_DIR="./stacks"

export PERSIST_DIR="${PERSIST_DIR:-../persist}"
export BACKUP_DIR="${BACKUP_DIR:-../persist/backups}"
export APTLY_GPG_DIR="${APTLY_GPG_DIR:-../persist/.gpg}"

if [[ ! -d "$STACKS_DIR" ]]; then
    echo "Error: '$STACKS_DIR' directory not found!"
    exit 1
fi

echo "Using PERSIST_DIR: $PERSIST_DIR"
echo "Using BACKUP_DIR: $BACKUP_DIR"
echo "Using APTLY_GPG_DIR: $APTLY_GPG_DIR"

COMPOSE_FILES=($(find "$STACKS_DIR" -type f -name "*.yml"))

if [[ ${#COMPOSE_FILES[@]} -eq 0 ]]; then
    echo "Error: No docker-compose files found in '$STACKS_DIR'."
    exit 1
fi

COMPOSE_CMD="docker compose"

for FILE in "${COMPOSE_FILES[@]}"; do
    COMPOSE_CMD+=" -f $FILE"
done

COMPOSE_CMD+=" down"

echo "Running: $COMPOSE_CMD"
eval "$COMPOSE_CMD"

echo "All stacks have been stopped."

export PERSIST_DIR BACKUP_DIR APTLY_GPG_DIR


