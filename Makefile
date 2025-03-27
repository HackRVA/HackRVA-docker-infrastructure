
all: pull-wiki-extensions start

start:
	bash scripts/start_all_stacks.sh

stop:
	bash scripts/stop_all_stacks.sh

pull-wiki-extensions:
	bash scripts/pull_wiki_extensions.sh

