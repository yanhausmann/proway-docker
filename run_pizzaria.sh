#!/bin/bash

set -e
REPO_URL="https://github.com/yanhausmann/proway-docker"
BASE_DIR="/opt/docker/composes"
DEST_DIR_BACKEND="/opt/docker/composes/proway-docker/pizzaria-app/backend"
DEST_DIR_FRONTEND="/opt/docker/composes/proway-docker/pizzaria-app/frontend"

sudo rm -rf /opt/docker/composes/proway-docker

sudo apt update -y
sudo apt install git -y
sudo apt install docker.io -y
sudo apt install docker-compose -y

sudo systemctl enable docker
sudo systemctl start docker

# Verifica se o diretório BASE_DIR existe
if [ ! -d "$BASE_DIR" ]; then
  read -p "Diretório $BASE_DIR não existe. Deseja criar? (s/n) " RESP
  case "$RESP" in
    [Ss]* )
      echo "Criando diretório $BASE_DIR..."
      sudo mkdir -p "$BASE_DIR"
      sudo chown "$USER":"$USER" "$BASE_DIR"
      ;;
    * )
      echo "Diretório $BASE_DIR não criado. Saindo."
      exit 1
      ;;
  esac
fi
cd $BASE_DIR



git clone $REPO_URL
cd /opt/docker/composes/proway-docker
sudo mv docker-compose.yml /opt/docker/composes/proway-docker/pizzaria-app

cd /opt/docker/composes/proway-docker/pizzaria-app
sudo docker-compose up --build -d

