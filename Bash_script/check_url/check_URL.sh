#!/bin/bash
clear

###############################
#
# Parametros:
#  - Lista Dominios y URL
#
#  Tareas:
#  - Se debera generar la estructura de directorio pedida con 1 solo comando con las tecnicas enseñadas en clases
#  - Generar los archivos de logs requeridos.
#
###############################
LISTA=$1

LOG_FILE="/var/log/status_url.log"
BASE_DIR="/tmp/head-check"
DIR_OBJETIVE=""

#Creo la estructura de directorios
mkdir -p /tmp/head-check/{Error/{cliente,servidor},ok/}

if [! -f "$LOG_FILE" ]; then
    echo "TIME - Code - URL" > "$LOG_FILE"
fi

if 

ANT_IFS=$IFS
IFS=$'\n'

#---- Dentro del bucle ----#
for LINEA in `cat $LISTA |  grep -v ^#`
do
  
  #Filtro el Dominio y la URL
  DOM=$(echo $LINEA | awk '{print $1}')
  URL=$(echo $LINEA | awk '{print $1}')

  # Obtener el código de estado HTTP
  STATUS_CODE=$(curl -LI -o /dev/null -w '%{http_code}\n' -s "$URL")

  # Fecha y hora actual en formato yyyymmdd_hhmmss
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

  #Asigno la url a el directorio en formato .log
  if [ "$STATUS_CODE" == 200 ]; then
        DIR_OBJETIVE="$BASE_DIR/ok"
  fi
  
  if [ ["$STATUS_CODE" -gt 399 && "$STATUS_CODE" -lt 500] ]; then
        DIR_OBJETIVE="$BASE_DIR/Error/cliente"
  fi

  if [ ["$STATUS_CODE" -ge 500 && "$STATUS_CODE" -lt 600] ]; then
        DIR_OBJETIVE="$BASE_DIR/Error/servidor"
  fi

  
  LOG_LINE="$TIMESTAMP - Code:$STATUS_CODE - URL:$URL"
  DOMAIN_LOG_FILE="$DIR_OBJETIVE/$DOM.log"

  echo "$LOG_LINE" > "$DOMAIN_LOG_FILE"

 # Registrar en el archivo /var/log/status_url.log
  echo "$TIMESTAMP - Code:$STATUS_CODE - URL:$URL" |sudo tee -a  "$LOG_FILE"


done
#-------------------------#

echo "Carga y verificacion completada"

IFS=$ANT_IFS
