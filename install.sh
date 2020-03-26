#!/bin/bash


echo "if you haven't done so already, you will have to add the cert and private key to # /etc/nginx/certificate.crt
# /etc/nginx/certificate.key"
echo ""

curl -L https://bootstrap.saltstack.com -o bootstrap_salt.sh
sudo sh bootstrap_salt.sh

if [[ $(grep "file_client: local" /etc/salt/minion | wc -l) == 0 ]]; then

	echo "file_client: local" >> /etc/salt/minion

fi

if [[ $(grep "database_password:" vars.yml | wc -l) == 0 ]]; then

        database_password=$(openssl rand -base64 30)
	echo "database_password: ${database_password}" >> vars.yml

fi

systemctl disable salt-minion 
systemctl stop salt-minion

salt-call --local state.apply

