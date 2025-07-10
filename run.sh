#######Initial Setup#######
#!/bin/bash
# This script is used to set up the environment for the ArrStack project.
# Install necessary packages and dependencies, create a Docker network, and start the Docker containers.
apt update && apt install -y \
    docker.io \
    docker-compose \
    git \
    curl \
    wget \
    unzip

sudo apt install apt-transport-https ca-certificates curl software-properties-common gnupg2 -y

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
apt update && apt install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
# It creates a Docker network and starts the Docker containers defined in the docker-compose.yml file.
sudo docker network create arrstack
docker compose up -d
