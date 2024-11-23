#!/bin/bash
# postgres/init-scripts/01-confi.sh

echo "Executing init-postgres.sh..."

# Verifica se os arquivos existem e têm as permissões corretas
echo "Verifyin SSL..."
ls -la /etc/postgresql/ssl/
echo "... done."

echo "Verifyin pg_hba.conf..."
ls -la /etc/data/pg_hba.conf
echo "... done."

echo "... init-postgres.sh executed."