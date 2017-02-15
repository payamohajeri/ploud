#!/bin/sh
wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
sudo echo 'deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main' > /etc/apt/sources.list.d/saltstack.list
sudo apt-get update -y
sudo apt-get install salt-minion -y
sudo update-rc.d salt-minion defaults
sudo update-rc.d salt-minion enable
sudo cp /vagrant/provisioning/saltstack/etc/minion /etc/salt/minion
sudo echo "192.168.41.11 salt" >> /etc/hosts
sudo /etc/init.d/salt-minion stop
if (( $(ps -ef | grep -v grep | grep salt-master | wc -l) > 0 )) then
  echo "salt-minion  is running!!!"
else
  echo "salt-minion is NOT running, going to run it ..."
  sudo salt-minion -d
  sleep 15
fi
