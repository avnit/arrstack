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

DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.38.2/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose


# It creates a Docker network and starts the Docker containers defined in the docker-compose.yml file.n
# create a env file 
echo "Creating .env file..."
echo "ARRPATH=/media" > .env
echo "CF_API_EMAIL=abambah@gmai.com" >> .env
echo "CF_API_KEY=1234567890" >> .env
echo "ARRSTACK_VERSION=latest" >> .env
sudo docker network create arrstack
docker compose up -d
