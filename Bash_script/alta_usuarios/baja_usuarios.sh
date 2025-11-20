#!/bin/bash
clear
LISTA=$1

ANT_IFS=$IFS
IFS=$'\n'
for LINEA in `cat $LISTA |  grep -v ^#`
do
	USUARIO=$(echo  $LINEA |awk -F ',' '{print $1}')
	GRUPO=$(echo  $LINEA |awk -F ',' '{print $2}')
	DIR_HOME_GRUPO=$(echo  $LINEA |awk -F ',' '{print $3}')
	sudo userdel -r $USUARIO 
	sudo groupdel $GRUPO
done
IFS=$ANT_IFS

