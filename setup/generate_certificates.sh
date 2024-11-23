#!/bin/bash

# Script to generate self-signed SSL/TLS certificates for internal domains

# Exit script if any command fails
set -e

# Variables
NGINX_SSL_DIR="../.ssl/nginx"
POSTGRES_SSL_DIR="../.ssl/postgres"
DOMAIN_NGINX="conectaai.app"
DOMAIN_POSTGRES="conectaai-db.app"
DAYS_VALID=365

# Create the directories to store the certificates if they don't exist
mkdir -p $NGINX_SSL_DIR
mkdir -p $POSTGRES_SSL_DIR

# Generate self-signed SSL certificate for NGINX
echo "Gerando certificado SSL autoassinado para NGINX..."
openssl req -x509 -nodes -days $DAYS_VALID -newkey rsa:2048 \
  -keyout $NGINX_SSL_DIR/server.key \
  -out $NGINX_SSL_DIR/server.crt \
  -subj "/CN=$DOMAIN_NGINX"

# Check if NGINX certificate generation was successful
if [ $? -eq 0 ]; then
  echo "Certificado NGINX gerado com sucesso!"
  echo "Certificados disponíveis em $NGINX_SSL_DIR/"
else
  echo "Erro ao gerar o certificado NGINX. Verifique as configurações."
  exit 1
fi

# Generate self-signed SSL certificate for PostgreSQL
echo "Gerando certificado SSL autoassinado para PostgreSQL..."
openssl req -x509 -nodes -days $DAYS_VALID -newkey rsa:2048 \
  -keyout $POSTGRES_SSL_DIR/server.key \
  -out $POSTGRES_SSL_DIR/server.crt \
  -subj "/CN=$DOMAIN_POSTGRES"

# Check if PostgreSQL certificate generation was successful
if [ $? -eq 0 ]; then
  echo "Certificado PostgreSQL gerado com sucesso!"
  echo "Certificados disponíveis em $POSTGRES_SSL_DIR/"
else
  echo "Erro ao gerar o certificado PostgreSQL. Verifique as configurações."
  exit 1
fi

# Set permissions for the secrets directory
chmod 600 $NGINX_SSL_DIR/server.key
chmod 644 $NGINX_SSL_DIR/server.crt

chown 999:999 $POSTGRES_SSL_DIR/server.key
chown 999:999 $POSTGRES_SSL_DIR/server.crt
chmod 0600 $POSTGRES_SSL_DIR/server.key
chmod 0640 $POSTGRES_SSL_DIR/server.crt

echo "Certificados SSL autoassinados gerados e copiados com sucesso."
