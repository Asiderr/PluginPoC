#!/bin/bash

function install_aws_sdk()
{
    # Clone aws-sdk-cpp source
    git clone --recurse-submodules https://github.com/aws/aws-sdk-cpp

    # Install dependencies
    apt install -y libcurl4-openssl-dev libssl-dev uuid-dev zlib1g-dev libpulse-dev

    # Build aws-sdk for C++ with S3 service
    mkdir sdk_build && cd sdk_build
    cmake ../aws-sdk-cpp -DCMAKE_BUILD_TYPE=Debug -DFORCE_SHARED_CRT=OFF -DBUILD_SHARED_LIBS=OFF -DCMAKE_PREFIX_PATH=/usr/ -DCMAKE_INSTALL_PREFIX=/usr/ -DBUILD_ONLY="s3"
    make -j $(nproc)

    # Install aws-sdk for C++
    make install
}

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt update
apt upgrade -y

install_aws_sdk
