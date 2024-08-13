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

| Package    | Minimum supported version |
| :-----     | :------------------------ |
| g++        | 13.2.0                    |
| clang      | 18.1.3                    |
| cmake      | 3.10                      |
| make       | 4.3                       |
| clang-tidy | 18.1.3                    |
| cppcheck   | 2.13.0                    |

### Building the project locally

You can build the project locally by running the following command:

```bash
mkdir -p build && cd build && cmake .. && make
```

CMake supports 2 build types: `Debug` and `Release`. The default type is `Release`. You can specify the build type by running the following command:

```bash
mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make
```

**Note** By default our build system treats warnings as errors. You can disable this behavior by setting the flag `CMAKE_WERROR=OFF` in the cmake command.
Example:

```bash
mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_WERROR=OFF .. && make
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

### VSCode setup

In this section you can find our suggested setup for VSCode. You can copy and paste the following configurations to your `.vscode/settings.json` file.
Or you can manually set them by going to `File -> Preferences -> Settings` and searching for the configuration you want to change.

##### Clangd

If you are using docker as a main build environment, you should use this configuration for clangd.
It will use docker artifacts to provide proper compile commands.

```json
{
    "clangd.path": "/usr/bin/clangd",
    "clangd.arguments": [
        "--compile-commands-dir=${workspaceFolder}/out/build",
        "--background-index",
        "--completion-style=detailed",
        "--header-insertion=never",
        "-log=info",
        "-pretty"
    ]
}
```

However, if you are using local build environment, you should use this configuration for clangd.
It will use local artifacts to provide proper compile commands.

```json
{
    "clangd.path": "/usr/bin/clangd",
    "clangd.arguments": [
        "--compile-commands-dir=${workspaceFolder}/build",
        "--background-index",
        "--completion-style=detailed",
        "--header-insertion=never",
        "-log=info",
        "-pretty"
    ]
}
```
