#!/bin/bash


database_password=$(grep "database_password" "/srv/salt/vars.yml" | cut -f2 -d' ')

sudo -u postgres psql -c "CREATE ROLE pwpusher_database_user;"
sudo -u postgres psql -c "ALTER ROLE pwpusher_database_user WITH ENCRYPTED PASSWORD '${database_password}';"
sudo -u postgres psql -c "ALTER ROLE pwpusher_database_user WITH LOGIN;"
sudo -u postgres psql -c "CREATE DATABASE pwpusher_database_user;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE pwpusher_database_user TO pwpusher_database_user;"
sudo -u postgres psql -c "CREATE DATABASE pwpusher;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE pwpusher TO pwpusher_database_user;"

if [[ $(grep "pwpusher_database_user" /etc/postgresql/10/main/pg_hba.conf | wc -l) == 0 ]]; then
	sed -i '1s/^/local   all   pwpusher_database_user   md5/' /etc/postgresql/10/main/pg_hba.conf
fi
