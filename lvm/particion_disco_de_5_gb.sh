#!/bin/bash

echo "PARTICION DEL DISCO DE 5GB:"

sudo fdisk /dev/sdc <<EOF
n
p
1

# el ENTER de arriba toma el primer sector por defecto
# el ENTER de abajo usa el 100% del espacio disponible

t
8e
w
EOF

sudo wipefs -a /dev/sdc1
