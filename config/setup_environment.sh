#!/bin/bash

# Atualizar o sistema
sudo yum update -y

# Instalar pacotes necessários
sudo yum install -y yum-utils curl

# Adicionar repositório Docker
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Instalar Docker
sudo yum install -y docker-ce docker-ce-cli containerd.io

# Iniciar e habilitar o Docker
sudo systemctl start docker
sudo systemctl enable docker

# Adicionar o usuário atual ao grupo docker (para evitar uso do sudo ao executar comandos Docker)
sudo usermod -aG docker $(whoami)

# Baixar a versão estável mais recente do Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/2.22.24/docker-compose-linux-$(uname -m)" -o /usr/local/bin/docker-compose

# Aplicar permissões executáveis ao binário
sudo chmod +x /usr/local/bin/docker-compose

# Verificar as instalações
docker --version
docker-compose --version

echo "Instalação concluída. Por favor, faça logout e login novamente para que as alterações de grupo tenham efeito."
