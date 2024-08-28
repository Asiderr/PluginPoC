# Plugin PoC

## Development setup

### Installing dependencies

You can install all devtools and dependencies by running proper scripts from `scripts/devenv/` directory.


| Environment | Script                                                                                 |
| :-----------| :--------------------------------------------------------------------------------------|
| Ubuntu      | [devenv-install-devtools-ubuntu.sh](./scripts/devenv/devenv-install-devtools-ubuntu.sh)|
| Docker      | [devenv-install-docker-ubuntu.sh](./scripts/devenv/devenv-install-docker-ubuntu.sh)    |
| aws-sdk-cpp | [devenv-setup-aws-env.sh](./scripts/devenv/devenv-setup-aws-env.sh)                    |

### VSCode setup

In this section you can find our suggested setup for VSCode. You can copy and paste the following configurations to your `.vscode/settings.json` file.
Or you can manually set them by going to `File -> Preferences -> Settings` and searching for the configuration you want to change.

#### Clangd

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

### AWS setup

#### Local installation of AWS SDK for cpp

**To setup aws-sdk-ccp [devenv-setup-aws-env.sh](scripts/devenv/devenv-setup-aws-env.sh)**

```bash
sudo ./scripts/devenv/devenv-setup-aws-env.sh
```

If you want, you can also do it manually with following commands.
Clone source-code:

```bash
git clone --recurse-submodules https://github.com/aws/aws-sdk-cpp
```

Install dependencies:

```bash
sudo apt-get install libcurl4-openssl-dev libssl-dev uuid-dev zlib1g-dev libpulse-dev
```

Create build directory outside sdk

```bash
mkdir ../sdk_build && cd ../sdk_build
```

Generate build files for core and S3 AWS services

```bash
cmake ../aws-sdk-cpp -DCMAKE_BUILD_TYPE=Debug -DFORCE_SHARED_CRT=OFF -DBUILD_SHARED_LIBS=OFF -DCMAKE_PREFIX_PATH=/usr/ -DCMAKE_INSTALL_PREFIX=/usr/ -DBUILD_ONLY="s3"
```

Build the sdk with core and S3 AWS services (It could take a long time.)

```bash
make
```

Install sdk

```bash
make install
```

#### Localstack installation

For testing purposes you can use LocalStack as a replacement for AWS.
You can use `pip` to install LocalStack (Python 3.7 to 3.11 required - we
recommend using virtual environment):

```bash
python3 -m pip install --upgrade localstack
```

Install `awscli` helper tools:

```
python3 -m pip awscli awscli-local
```

For another installation methods check
[LocalStack official documentation](https://docs.localstack.cloud/getting-started/installation/).

**You have to create `~/.aws/credential` file to use LocalStack with AWS SDK.**
The `~/.aws/credential` needs to contain the following entries:

```
[default]
aws_access_key_id=test
aws_secret_access_key=test

[admin]
aws_access_key_id=test
aws_secret_access_key=test
```

---

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

---

## Usage example

This PoC uses Daemon to connect to the LocalStack and it checks existing
S3 buckets.

Start LocalStack:

```bash
localstack start
```

Create sample S3 bucket using `awscli-local`:

```bash
awslocal s3api create-bucket --bucket test-bucket
```

Run daemon.out binary. (Make sure that `~/.aws/credential` file exists!):

```bash
./daemon.out

Daemon
Found 1 bucket
test-bucket
```
