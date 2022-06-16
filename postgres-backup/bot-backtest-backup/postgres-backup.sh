#!/bin/bash

cd /home/root
date1=$(date +"%m-%d-%Y-%H-%M")
export LC_ALL=C
touch /root/.pgpass
echo "$PGPASS" > /root/.pgpass
chmod 600 /root/.pgpass
file_name=backup-$date1.dump.gz
pg_dump -Fc -Z 0 -d $DBNAME -U $DBUSER -h $DBHOST -p $DBPORT | pigz > $file_name
aws s3 cp $file_name $S3_BUCKET

# pg_restore -Fc -j 8 -h localhost -U postgres -d postgres -v backup-$date1.dump

