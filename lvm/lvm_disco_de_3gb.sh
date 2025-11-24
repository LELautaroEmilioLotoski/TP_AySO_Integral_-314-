#!/bin/bash


echo "GENERAMOS EL PV:"

sudo pvcreate /dev/sdd1

echo "GENERAMOS EL vg_temp:"

sudo vgcreate vg_temp /dev/sdd1

echo "GENERAMOS EL lv_swap:"

sudo lvcreate vg_temp -L2.5G -n lv_swap

echo "FORMATEAMOS EL lv_swap EN SWAP:"

sudo mkswap /dev/mapper/vg_temp-lv_swap

echo "MONTAMOS EL lv_swap COMO SWAP:"

sudo swapon /dev/mapper/vg_temp-lv_swap

echo "MOSTRAMOS QUE TODO SALIO BIEN:"

free -h


