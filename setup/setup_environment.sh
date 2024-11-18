#!/bin/bash

# Atualizar o sistema
sudo dnf update -y

# Instalar pacotes necessários
sudo dnf install -y curl
sudo dnf -y install dnf-plugins-core

sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# Adicionar repositório Docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Instalar Docker
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Iniciar e habilitar o Docker
sudo systemctl enable --now docker

# Test docker 
sudo docker run hello-world

# Adicionar o usuário atual ao grupo docker (para evitar uso do sudo ao executar comandos Docker)
sudo usermod -aG docker $(whoami)

# Baixar a versão estável mais recente do Docker Compose
#sudo curl -L "https://github.com/docker/compose/releases/download/2.22.24/docker-compose-linux-$(uname -m)" -o /usr/local/bin/docker-compose

# Aplicar permissões executáveis ao binário
#sudo chmod +x /usr/local/bin/docker-compose

# Verificar as instalações
docker swarm init
docker --version
docker compose version

echo "Instalação concluída. Por favor, faça logout e login novamente para que as alterações de grupo tenham efeito."
