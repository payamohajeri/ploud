# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "master" do |master_config|
    master_config.vm.box = "ubuntu/xenial64"
    master_config.vm.box_check_update = true
    master_config.vm.network "forwarded_port", guest: 80, host: 8081
    master_config.vm.network "private_network", ip: "192.168.40.10"
    master_config.vm.synced_folder "./", "/vagrant"

    master_config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
      vb.name = "ploud-master"
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
    end

    master_config.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get upgrade -y
    SHELL

    master_config.vm.provision "ansible_local" do |ansible|
      ansible.provisioning_path = "/vagrant/provisioning/ansible"
      ansible.playbook = "./master-playbook.yml"
      ansible.inventory_path = "./inventory/hosts"
      ansible.limit = "master"
      ansible.verbose = true
    end

    master_config.vm.provision "docker" do |docker|
      docker.build_image "/vagrant/provisioning/docker/web1/", args: "-t web1:latest"
      docker.run "web1:latest", cmd: "tail -f /dev/null", args: "-v '/vagrant/app/web1:/app' --name web1"
    end

    master_config.vm.provision "ansible_local" do |ansible|
      ansible.provisioning_path = "/vagrant/provisioning/ansible"
      ansible.playbook = "./node1-playbook.yml"
      ansible.inventory_path = "./inventory/hosts"
      ansible.limit = "node1"
      ansible.verbose = true
    end
  end

  config.vm.define "salt_master" do |salt_master_config|
    salt_master_config.vm.box = "ubuntu/xenial64"
    salt_master_config.vm.box_check_update = true
    salt_master_config.vm.network "forwarded_port", guest: 80, host: 8082
    salt_master_config.vm.network "private_network", ip: "192.168.40.11"
    salt_master_config.vm.synced_folder "./", "/vagrant"
    salt_master_config.vm.synced_folder "./provisioning/saltstack/salt", "/srv/salt"
    salt_master_config.vm.synced_folder "./provisioning/saltstack/pillar", "/srv/pillar"


    salt_master_config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
      vb.name = "ploud-salt-master"
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
    end
    salt_master_config.vm.provision "shell", path: "provisioning/shell/setup-salt-master.sh"
  end

  config.vm.define "node1" do |node1_config|
    node1_config.vm.box = "ubuntu/xenial64"
    node1_config.vm.box_check_update = true
    node1_config.vm.network "forwarded_port", guest: 80, host: 8083
    node1_config.vm.network "private_network", ip: "192.168.40.12"
    node1_config.vm.synced_folder "./", "/vagrant"

    node1_config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
      vb.name = "ploud-node1"
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
    end
    node1_config.vm.provision "shell", path: "provisioning/shell/setup-salt-minion.sh"
  end

  config.vm.define "node2" do |node2_config|
    node2_config.vm.box = "ubuntu/xenial64"
    node2_config.vm.box_check_update = true
    node2_config.vm.network "forwarded_port", guest: 80, host: 8084
    node2_config.vm.network "private_network", ip: "192.168.40.13"
    node2_config.vm.synced_folder "./", "/vagrant"

    node2_config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
      vb.name = "ploud-node2"
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
    end
    node2_config.vm.provision "shell", path: "provisioning/shell/setup-salt-minion.sh"
  end
end
