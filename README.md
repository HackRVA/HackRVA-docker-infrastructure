# HackRVA-docker-infrastructure

Various Dockerfiles and configuration files to allow restoring HackRVA's
non-vital infrastructure quickly when necessary

## Run

stand up all containers
```bash
make
```

stop all containers
```bash
make stop
```

## Stacks

Each service lives in its own compose file under `stacks/`, pulled together by
the root `compose.yaml` via `include`. To add a stack, drop the file in
`stacks/` and add it to the `include` list.

Paths inside a stack file are relative to `stacks/`, so repo-root files are
referenced as `../db.env`, `../wiki/LocalSettings.php`, etc.

