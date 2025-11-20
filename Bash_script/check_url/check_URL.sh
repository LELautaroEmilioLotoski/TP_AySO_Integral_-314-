#!/bin/bash
clear

LISTA=$1

LOG_FILE="/var/log/status_url.log"
BASE_DIR="/tmp/head-check"
DIR_OBJETIVE=""

# Crear estructura de directorios
mkdir -p "$BASE_DIR"/{Error/{cliente,servidor},ok}

# Crear log principal si no existe
if [ ! -f "$LOG_FILE" ]; then
    echo "TIME - Code - URL" | sudo tee "$LOG_FILE"
fi

ANT_IFS=$IFS
IFS=$'\n'

# Procesar lista
for LINEA in $(grep -v ^# "$LISTA")
do
  DOM=$(echo "$LINEA" | awk '{print $1}')
  URL=$(echo "$LINEA" | awk '{print $2}')

  STATUS_CODE=$(curl -LI -o /dev/null -w '%{http_code}\n' -s "$URL")

  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

  # Clasificación por código
  if [ "$STATUS_CODE" -eq 200 ]; then
      DIR_OBJETIVE="$BASE_DIR/ok"
  elif [ "$STATUS_CODE" -gt 399 ] && [ "$STATUS_CODE" -lt 500 ]; then
      DIR_OBJETIVE="$BASE_DIR/Error/cliente"
  elif [ "$STATUS_CODE" -ge 500 ] && [ "$STATUS_CODE" -lt 600 ]; then
      DIR_OBJETIVE="$BASE_DIR/Error/servidor"
  else
      DIR_OBJETIVE="$BASE_DIR/Error/cliente"   # Otros códigos
  fi

  DOMAIN_LOG_FILE="$DIR_OBJETIVE/$DOM.log"

  LOG_LINE="$TIMESTAMP - Code:$STATUS_CODE - URL:$URL"

  echo "$LOG_LINE" > "$DOMAIN_LOG_FILE"

  echo "$LOG_LINE" | sudo tee -a "$LOG_FILE"

done

echo "Carga y verificacion completada"

IFS=$ANT_IFS

