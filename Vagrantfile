# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "genebean/centos6-64bit"

  config.vm.hostname = "puppet"

  # Install Puppet and needed modules
  config.vm.provision "shell", path:   "scripts/envsetup.sh"
  config.vm.provision "shell", path:   "scripts/puppet.sh"
  config.vm.provision "shell", path:   "scripts/copy-files.sh"
  config.vm.provision "shell", path:   "scripts/r10k.sh"

  # Setup r10k
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "scripts"
    puppet.manifest_file  = "r10k_installation.pp"
  end
  
  # The manifest above ends with some errors... this tells us Vagrant continued.
  config.vm.provision "shell", inline: "echo Finished running r10k_installation.pp"

  config.vm.provider "vmware_desktop" do |v|
    v.gui = false
  end
  
  config.vm.provider "vmware_fusion" do |v|
    v.gui = false
  end

  config.vm.provider "virtualbox" do |v|
    v.gui = false
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
end
