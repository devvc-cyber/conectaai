#!/bin/bash

# Script to generate self-signed SSL/TLS certificates for internal domains

# Exit script if any command fails
set -e

# Variables
NGINX_CERT_DIR="../.certs/nginx"
POSTGRES_CERT_DIR="../.certs/postgres"
DOMAIN_NGINX="conectaai-nginx.local"
DOMAIN_POSTGRES="conectaai-postgres.local"
SECRETS_DIR="../.secrets"
DAYS_VALID=365

# Create the directories to store the certificates if they don't exist
mkdir -p $NGINX_CERT_DIR
mkdir -p $POSTGRES_CERT_DIR
mkdir -p $SECRETS_DIR

# Generate self-signed SSL certificate for NGINX
echo "Gerando certificado SSL autoassinado para NGINX..."
openssl req -x509 -nodes -days $DAYS_VALID -newkey rsa:2048 \
  -keyout $NGINX_CERT_DIR/nginx_ssl_key.pem \
  -out $NGINX_CERT_DIR/nginx_ssl_cert.pem \
  -subj "/CN=$DOMAIN_NGINX"

# Check if NGINX certificate generation was successful
if [ $? -eq 0 ]; then
  echo "Certificado NGINX gerado com sucesso!"
  echo "Certificados disponíveis em $NGINX_CERT_DIR/"
else
  echo "Erro ao gerar o certificado NGINX. Verifique as configurações."
  exit 1
fi

# Generate self-signed SSL certificate for PostgreSQL
echo "Gerando certificado SSL autoassinado para PostgreSQL..."
openssl req -x509 -nodes -days $DAYS_VALID -newkey rsa:2048 \
  -keyout $POSTGRES_CERT_DIR/postgres_ssl_key.pem \
  -out $POSTGRES_CERT_DIR/postgres_ssl_cert.pem \
  -subj "/CN=$DOMAIN_POSTGRES"

# Check if PostgreSQL certificate generation was successful
if [ $? -eq 0 ]; then
  echo "Certificado PostgreSQL gerado com sucesso!"
  echo "Certificados disponíveis em $POSTGRES_CERT_DIR/"
else
  echo "Erro ao gerar o certificado PostgreSQL. Verifique as configurações."
  exit 1
fi

# Copy the generated certificates to the secrets directory
cp $NGINX_CERT_DIR/nginx_ssl_cert.pem $SECRETS_DIR/nginx_ssl_cert
cp $NGINX_CERT_DIR/nginx_ssl_key.pem $SECRETS_DIR/nginx_ssl_key
cp $POSTGRES_CERT_DIR/postgres_ssl_cert.pem $SECRETS_DIR/postgres_ssl_cert
cp $POSTGRES_CERT_DIR/postgres_ssl_key.pem $SECRETS_DIR/postgres_ssl_key

# Set permissions for the secrets directory
chmod 600 $SECRETS_DIR/nginx_ssl_key
chmod 644 $SECRETS_DIR/nginx_ssl_cert
chmod 600 $SECRETS_DIR/postgres_ssl_key
chmod 644 $SECRETS_DIR/postgres_ssl_cert

echo "Certificados SSL autoassinados gerados e copiados com sucesso."
