# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.ssh.username = "vagrant"
  config.ssh.shell = "bash -l"

  config.vm.synced_folder ".", "/usr/src/app"

  config.vm.define "web" do |web|
    web.vm.box      = "ubuntu/trusty64"
    web.vm.hostname = "web"

    web.vm.network :private_network, :ip => "172.51.1.100"
    web.vm.provision :hosts

    web.vm.provider "virtualbox" do |v|
	  v.memory = 1024
	  v.cpus = 1
	end

    web.vm.provision :shell, path: "system/scripts/install-ruby.sh", keep_color: true
    web.vm.provision :shell, path: "system/scripts/install-bundler.sh", keep_color: true
    web.vm.provision :shell, path: "system/scripts/install-rails.sh", keep_color: true
    web.vm.provision :shell, path: "system/scripts/install-app.sh", keep_color: true
    web.vm.provision :shell, inline: "cp -f /usr/src/app/init/app.conf /etc/init/app.conf"
    web.vm.provision :shell, inline: "service app restart"
  end
  
  config.vm.define "docker" do |docker|
  	docker.vm.hostname = "db"
  	docker.vm.box      = "ubuntu/trusty64"
  	docker.vm.network :private_network, :ip => "172.51.1.101"
    docker.vm.provision :hosts

    docker.vm.provider "virtualbox" do |v|
	  v.memory = 2048
	  v.cpus = 2
	end

    docker.vm.provision :shell, path: "system/scripts/install-docker.sh", keep_color: true
    docker.vm.provision :shell, path: "system/scripts/install-docker-compose.sh", keep_color: true
    docker.vm.provision :shell, inline: "docker pull postgres"
    docker.vm.provision :shell, inline: "cp -f /usr/src/app/init/app-services.conf /etc/init/app-services.conf"
    docker.vm.provision :shell, inline: "service app-services restart"
  end
end