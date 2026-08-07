
PERSIST_DIR ?= ../persist
BACKUP_DIR ?= ../persist/backups
APTLY_GPG_DIR ?= ../persist/.gpg
export PERSIST_DIR BACKUP_DIR APTLY_GPG_DIR

all: pull-wiki-extensions start

start:
	bash scripts/ensure_env_files.sh
	docker compose up -d

stop:
	docker compose down

pull-wiki-extensions:
	bash scripts/pull_wiki_extensions.sh
