# Plugin PoC

## Usage

```bash
DOCKER_BUILDKIT=1 docker build --no-cache --file docker/Dockerfile-ubuntu-devenv --output out .
```

## Development setup

### Installing dependencies

You can install all devtools and dependencies by running proper script from `scripts/devenv/` directory.


| OS    | Script                                                               |
| :-----| :--------------------------------------------------------------------|
| Ubuntu| [devenv-install-ubuntu.sh](./scripts/devenv/devenv-install-ubuntu.sh)|
