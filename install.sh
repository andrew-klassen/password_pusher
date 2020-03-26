#!/bin/bash


curl -L https://bootstrap.saltstack.com -o bootstrap_salt.sh
sudo sh bootstrap_salt.sh

if [[ $(grep "file_client: local" /etc/salt/minion | wc -l) == 0 ]]; then
	echo "file_client: local" >> /etc/salt/minion
fi

systemctl disable salt-minion 
systemctl stop salt-minion

salt-call --local state.apply

