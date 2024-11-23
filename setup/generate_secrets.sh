#!/bin/bash

# Diretório onde os segredos serão armazenados
SECRETS_DIR="../.secrets"

# Criação do diretório de segredos
if [ ! -d "$SECRETS_DIR" ]; then
  echo "Criando diretório de segredos em $SECRETS_DIR..."
  mkdir -p "$SECRETS_DIR"
else
  echo "Diretório $SECRETS_DIR já existe. Continuando..."
fi

# Função para criar um segredo
generate_secret() {
  local filename="$1"
  local length="$2"
  
  # Gerar valor aleatório e salvar no arquivo
  openssl rand -hex "$length" > "$SECRETS_DIR/$filename"
  echo "Segredo criado: $SECRETS_DIR/$filename"
}

# Lista de segredos a serem gerados (arquivo: tamanho em bytes)
declare -A SECRETS=(
  ["app_keys"]=32
  ["api_token_salt"]=16
  ["admin_jwt_secret"]=32
  ["transfer_token_salt"]=16
  ["jwt_secret"]=32
  ["strapi_admin_client_preview_secret"]=32
  ["postgres_password"]=16
  ["pgadmin_password"]=16
)

# Gerar cada segredo
for secret in "${!SECRETS[@]}"; do
  generate_secret "$secret" "${SECRETS[$secret]}"
done

echo "strapi" > $SECRETS_DIR/postgres_user
echo "strapidb" > $SECRETS_DIR/postgres_db
echo "rafael@volvecare.com" > $SECRETS_DIR/pgadmin_email

# Ajustar permissões
echo "Ajustando permissões dos arquivos de segredos..."
chmod 600 "$SECRETS_DIR"/*

echo "Todos os segredos foram gerados com sucesso e estão armazenados em $SECRETS_DIR"
