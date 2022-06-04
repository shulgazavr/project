#!/bin/bash

DIR='/usr/local/bckp_mysql'
DATE=`date +"%Y%m%d"`
MYSQL='mysql --skip-column-names'

mkdir $DIR/$DATE;

`$MYSQL -e "stop slave"`

for db in `$MYSQL -e "show databases like '%\_dz';"`; do
	for tbl in `$MYSQL -e "show tables from $db;"`; do
	    /usr/bin/mysqldump --add-drop-table --add-locks --create-options --disable-keys --extended-insert --single-transaction --quick --set-charset --events --routines --triggers --master-data=2  $db $tbl > /$DIR/$DATE/$db_$tbl;
	done
done

`$MYSQL -e "start slave"`