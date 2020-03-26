#!/bin/bash

sudo -u postgres psql -c "CREATE ROLE pwpusher_database_user WITH ENCRYPTED PASSWORD 'test;"
sudo -u postgres psql -c "ALTER ROLE pwpusher_database_user WITH LOGIN;"
sudo -u postgres psql -c "CREATE DATABASE pwpusher_database_user;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE pwpusher_database_user TO pwpusher_database_user;"
sudo -u postgres psql -c "CREATE DATABASE pwpusher;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE pwpusher TO pwpusher_database_user;"

if [[ $(grep "pwpusher_database_user" /etc/postgresql/10/main/pg_hba.conf | wc -l) == 1 ]]; then
	echo "local   all   pwpusher_database_user   md5" >> /etc/postgresql/10/main/pg_hba.conf
fi
