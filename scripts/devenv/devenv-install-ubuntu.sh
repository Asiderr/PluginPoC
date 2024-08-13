#!/bin/bash

function install_docker()
{
    # Check if docker is already installed
    if [ -x "$(command -v docker)" ]; then
        echo "Docker is already installed"
        return 0
    fi

    # Add official docker GPG key
    apt install ca-certificates curl
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Install Docker
    apt update
    apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Post-installation steps like adding user to docker group and starting docker service
    sudo usermod -aG docker ${USER}
    sudo systemctl enable docker
    sudo systemctl start docker

    return 0
}

function install_dev_tools()
{
    apt install -y gcc g++ clang clang-tools llvm lld
    apt install -y make cmake
    apt install -y git
    apt install -y python3 python3-pip
    apt install -y curl wget gawk sed grep
    apt install -y clang-tidy
    
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
install_docker
