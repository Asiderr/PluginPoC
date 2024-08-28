#!/bin/bash

function install_dev_tools()
{
    apt install -y gcc g++ clang clang-tools llvm lld
    apt install -y make cmake
    apt install -y git
    apt install -y python3 python3-pip
    apt install -y curl wget gawk sed grep
    apt install -y clang-tidy
    apt install -y cppcheck
    apt install -y rpm

    return 0
}

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt update
apt upgrade -y

install_dev_tools
