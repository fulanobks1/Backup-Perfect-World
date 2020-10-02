#!/bin/bash
data=$(date "+%F")

##################################################################

nome=New History
ip=IP_DA_SUA_MAQUINA

##################################################################

echo "Iniciando o salvamento do Backup"
echo "Backup $nome - Data: $data"
echo ""
##################################################################

echo "Baixando o Backup"
cd /Backupsalvo/

wget http://$ip:80/totalbackup/$data-mysql.tar.bz2
wget http://$ip:80/totalbackup/$data-logs.tar.bz2
wget http://$ip:80/totalbackup/$data.tar.bz2

echo "Backup baixado com Sucesso!"
