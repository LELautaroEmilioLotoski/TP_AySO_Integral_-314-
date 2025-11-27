#!/bin/bash

echo "PARTICION DEL DISCO DE 3GB:"

sudo fdisk /dev/sdd <<EOF
n
p
1

#
#

t
8e
w
EOF

sudo wipefs -a /dev/sdd1

  
