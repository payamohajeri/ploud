# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = true
  config.vm.network "forwarded_port", guest: 80, host: 8081
  config.vm.network "private_network", ip: "192.168.40.10"
  config.vm.synced_folder "./", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.name = "ploud"
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get upgrade -y
  SHELL

  config.vm.provision "ansible_local" do |ansible|
    ansible.provisioning_path = "/vagrant/provisioning/ansible"
    ansible.playbook = "./master-playbook.yml"
    ansible.inventory_path = "./inventory/hosts"
    ansible.limit = "master"
    ansible.verbose = true
  end

  config.vm.provision "docker" do |docker|
    docker.build_image "/vagrant/provisioning/docker/web1/", args: "-t web1:latest"
    docker.run "web1:latest", cmd: "tail -f /dev/null", args: "-v '/vagrant/app/web1:/app' --name web1"
  end

  config.vm.provision "ansible_local" do |ansible|
    ansible.provisioning_path = "/vagrant/provisioning/ansible"
    ansible.playbook = "./node1-playbook.yml"
    ansible.inventory_path = "./inventory/hosts"
    ansible.limit = "node1"
    ansible.verbose = true
  end

end
