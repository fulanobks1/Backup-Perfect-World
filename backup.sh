#!/bin/bash
data=$(date "+%F")

##################################################################

BasePW=PWServer
nome=New History
basededados=pw
userdb=root
senhadb=SUASENHA

##################################################################

echo "Iniciando o Backup.."
echo "Backup $nome - Data: $data"
echo ""
##################################################################

echo "Salvando dados do jogo e de Personagens"
cd /$BasePW/meubackup/

mkdir $data
cd $data

mkdir gamedbd
cd gamedbd

mkdir dbhomewdb
cd dbhomewdb

mkdir dblogs
mkdir dbdata

cp -R /$BasePW/gamedbd/dbhomewdb/dblogs/* /$BasePW/meubackup/$data/gamedbd/dbhomewdb/dblogs
cp -R /$BasePW/gamedbd/dbhomewdb/dbdata/* /$BasePW/meubackup/$data/gamedbd/dbhomewdb/dbdata

sleep 1
##################################################################

echo "Salvando dados de nomes"
cd /$BasePW/meubackup/$data

mkdir uniquenamed
cd uniquenamed

mkdir uname

cd uname
mkdir dblogs
mkdir dbdata

cp -R /$BasePW/uniquenamed/uname/dblogs/* /$BasePW/meubackup/$data/uniquenamed/uname/dblogs/
cp -R /$BasePW/uniquenamed/uname/dbdata/* /$BasePW/meubackup/$data/uniquenamed/uname/dbdata/

sleep 1
##################################################################

echo "Salvando Logs"
cd /$BasePW/meubackup/

mkdir $data-logs
cp -R /$BasePW/logs/ /$BasePW/meubackup/$data-logs

sleep 1
##################################################################

echo "Salvando o Banco de Dados"
cd /$BasePW/meubackup

mkdir $data-mysql

mysqldump -u $userdb -p$senhadb $basededados > /$BasePW/meubackup/$data-mysql/pw.sql

sleep 1
##################################################################

echo "Compactando todos os arquivos..."
echo "Enviando os arquivos para o apache"

cd /$BasePW/meubackup/
tar -cf $data-mysql.tar $data-mysql
bzip2 $data-mysql.tar
rm -rf $data-mysql
cp -R $data-mysql.tar.bz2 /var/www/html/totalbackup/

cd /$BasePW/meubackup/
tar -cf $data-logs.tar $data-logs
bzip2 $data-logs.tar
rm -rf $data-logs
cp -R $data-logs.tar.bz2 /var/www/html/totalbackup/

cd /$BasePW/meubackup/
tar -cf $data.tar $data
bzip2 $data.tar
rm -rf $data
cp -R $data.tar.bz2 /var/www/html/totalbackup/

echo "Backup feito com Sucesso!"
