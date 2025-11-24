#!/bin/bash

#Este script se ejecutara una vez unicamente cuando se creen las maquinas 

#Generamos clave si no existe 
if [ ! -f /home/vagrant/.ssh/id_ed25519.pub ]; then #si la clave no existe 
	ssh-keygen -t ed25519 -f /home/vagrant/.ssh/id_ed25519 -N "" # creamos una y direccionamos
fi

DESTINO=$1

# Copiar clave sin preguntar
ssh-copy-id -o StrictHostKeyChecking=no vagrant@$DESTINO
