# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box      = "ubuntu/trusty64"
  config.vm.hostname = "barker-webapp"

  config.vm.synced_folder ".", "/usr/src/app"

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :shell, path: "system/scripts/install-ruby.sh", keep_color: true
  config.vm.provision :shell, path: "system/scripts/install-bundler.sh", keep_color: true
  config.vm.provision :shell, path: "system/scripts/install-rails.sh", keep_color: true
  config.vm.provision :shell, path: "system/scripts/install-app.sh", keep_color: true
  config.vm.provision :shell, path: "system/scripts/run-app.sh", keep_color: true
end