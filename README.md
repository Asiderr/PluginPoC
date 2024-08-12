# Plugin PoC

## Build

You can build the project without thinking about dependencies by using Docker.

```bash
DOCKER_BUILDKIT=1 docker build --no-cache --file docker/Dockerfile-ubuntu-devenv --output out .
```

### Prerequisites

See [Development setup](#development-setup) for installing dependencies.
If your OS is not supported by the script, you can use Docker to build the project or install dependencies manually.

##### DEPENDENCIES:

| Package | Minimum supported version |
| :-----| :---------------------------|
| g++     | 13.2.0                    |
| clang   | 18.1.3                    |
| cmake   | 3.10                      |
| make    | 4.3                       |

### Building the project locally

You can build the project locally by running the following command:

```bash
mkdir -p build && cd build && cmake .. && make
```

CMake supports 2 build types: `Debug` and `Release`. You can specify the build type by running the following command:

```bash
mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make
```

### Building the project using Docker

You can build the project using Docker by running the following command:

```bash
DOCKER_BUILDKIT=1 docker build --no-cache --file docker/Dockerfile-ubuntu-build --output out .
```

## Development setup

### Installing dependencies

You can install all devtools and dependencies by running proper script from `scripts/devenv/` directory.


| OS    | Script                                                               |
| :-----| :--------------------------------------------------------------------|
| Ubuntu| [devenv-install-ubuntu.sh](./scripts/devenv/devenv-install-ubuntu.sh)|
