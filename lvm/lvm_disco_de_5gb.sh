#!/bin/bash

echo "CREAMOS EL PV DE SDC1:"

sudo pvcreate /dev/sdc1

echo "CREAMOS EL VG SDC1:"

sudo vgcreate vg_datos /dev/sdc1

echo "CREAMOS EL lv_workareas DE SDC1:"

sudo lvcreate vg_datos -L +2.5G -n lv_workareas

echo "FORMATEAMOS EL lv_workareas:"

sudo mkfs.ext4 -F /dev/mapper/vg_datos-lv_workareas

echo "MONTAMOS EL lv_workareas EN /WORK/:"

sudo mount /dev/mapper/vg_datos-lv_workareas /work/

echo "CREAMOS EL LV: lv_docker DE SDC1:"

sudo lvcreate vg_datos -L +10M -n lv_docker

echo "FORMATEAMOS EL lv_docker DE SDC1:"

sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker

echo "MONTAMOS EL /var/lib/docker/:"

sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker/

