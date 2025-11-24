#!/bin/bash

echo "HACEMOS LA PARTICION DEL DISCO DE 2GB /dev/sde:"

sudo fdisk /dev/sde <<EOF
n
p
1

+1G
t
82
w
EOF

sudo wipefs -a /dev/sde1


echo "LA FORMATEAMOS EN TIPO SWAP:"

sudo mkswap /dev/sde1

echo "ACTIVAMOS EL SWAP DEL FORMATEO QUE HICIMOS RECIEN:"

sudo swapon /dev/sde1

echo "VERIFICAMOS QUE ESTE ACTIVADA CORRECTAMENTE:"

swapon --show

