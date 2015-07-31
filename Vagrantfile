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

  config.vm.define "docker" do |node|
  	node.vm.hostname = "services.barker.internal"
  	node.vm.box      = "ubuntu/trusty64"
  	node.vm.network :private_network, :ip => "172.51.1.101"
    node.vm.provision :hosts
    node.hostmanager.aliases = %w(postgres.barker.internal consul.barker.internal)

    node.vm.provider "virtualbox" do |v|
	  v.memory = 2048
	  v.cpus = 2
	end

    node.vm.provision :shell, path: "system/scripts/install-docker.sh", keep_color: true
    node.vm.provision :shell, path: "system/scripts/install-docker-compose.sh", keep_color: true
    node.vm.provision :shell, path: "system/scripts/install-consulate.sh", keep_color: true
    node.vm.provision :shell, inline: "docker pull postgres:latest"
    node.vm.provision :shell, inline: "docker pull progrium/consul:latest"
    node.vm.provision :shell, inline: "docker pull spantree/elk:latest"
    node.vm.provision :shell, inline: "cp -f /usr/src/app/etc/init/app-services.conf /etc/init/app-services.conf"
    node.vm.provision :shell, inline: "service app-services restart"
  end

  config.vm.define "web" do |node|
    node.vm.box      = "ubuntu/trusty64"
    node.vm.hostname = "web.barker.internal"

    node.vm.network :private_network, :ip => "172.51.1.100"

    node.vm.provider "virtualbox" do |v|
	  v.memory = 1024
	  v.cpus = 1
	end

	config.vm.provision :hosts do |provisioner|
		provisioner.add_host "172.51.1.101", [
			"postgres.barker.internal",
			"consul.barker.internal"
		]
	end

    node.vm.provision :shell, path: "system/scripts/install-ruby.sh", keep_color: true
    node.vm.provision :shell, path: "system/scripts/install-bundler.sh", keep_color: true
    node.vm.provision :shell, path: "system/scripts/install-rails.sh", keep_color: true
    node.vm.provision :shell, path: "system/scripts/install-app.sh", keep_color: true
    node.vm.provision :shell, path: "system/scripts/configure-app-service.sh", keep_color: true
    node.vm.provision :shell, inline: "service app restart"
  end
end