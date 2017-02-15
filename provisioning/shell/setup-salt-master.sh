#!/bin/sh
wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
sudo echo 'deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main' > /etc/apt/sources.list.d/saltstack.list
sudo apt-get update -y
sudo apt-get install salt-master -y
sudo cp /vagrant/provisioning/saltstack/etc/autosign.conf /etc/salt/autosign.conf
sudo cp /vagrant/provisioning/saltstack/etc/master /etc/salt/master
sudo update-rc.d salt-master defaults
sudo update-rc.d salt-master enable
sudo service salt-master start
