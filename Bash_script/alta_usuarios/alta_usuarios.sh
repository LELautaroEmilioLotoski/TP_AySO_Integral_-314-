#!/bin/bash
clear

###############################
#
# Parametros:
#  - Lista de Usuarios a crear
#  - Usuario del cual se obtendra la clave
#
#  Tareas:
#  - Crear los usuarios segun la lista recibida en los grupos descriptos
#  - Los usuarios deberan de tener la misma clave que la del usuario pasado por parametro
#
###############################

LISTA=$1
USUARIO_HASH=$2
echo
echo "Lista: $1 Usuario-Clave: $2"

HASH=$(sudo grep $USUARIO_HASH /etc/shadow | awk -F ':' '{print $2}')


ANT_IFS=$IFS
IFS=$'\n'
for LINEA in `cat $LISTA |  grep -v ^#`
do
	USUARIO=$(echo  $LINEA |awk -F ',' '{print $1}')
	GRUPO=$(echo  $LINEA |awk -F ',' '{print $2}')
	DIR_HOME_GRUPO=$(echo  $LINEA |awk -F ',' '{print $3}')

	FLAG_GRUPO_EXISTE=$(grep $GRUPO /etc/group -c)
	if [$FLAG_GRUPO_EXISTE == 0 ]; then
	   echo "El grupo no existe - crear - valor: $FLAG_GRUPO_EXISTE"
	   sudo groupadd $GRUPO
	fi


	sudo useradd -m -s /bin/bash -g $GRUPO -d ${DIR_HOME_GRUPO} -p "$HASH" $USUARIO
done
IFS=$ANT_IFS

