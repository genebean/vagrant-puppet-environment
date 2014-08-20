# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "genebean/centos6-64bit"

  config.vm.define "pm" do |pm|
    pm.vm.hostname = "pm.localdomain"

    pm.vm.provision "shell", path:   "scripts/envsetup.sh"
    pm.vm.provision "shell", path:   "scripts/puppet.sh"
    pm.vm.provision "shell", inline: "puppet apply /vagrant/scripts/local-hosts.pp"
    pm.vm.provision "shell", inline: "puppet module install theforeman-puppet"
    pm.vm.provision "shell", path:   "scripts/copy-files.sh"
    pm.vm.provision "shell", path:   "scripts/hieradata.sh"
    pm.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-master-1.pp"
    pm.vm.provision "shell", path:   "scripts/r10k-module.sh"
    pm.vm.provision "shell", inline: "puppet apply /vagrant/scripts/r10k_installation.pp --test --verbose; echo 'Finished installing r10k.'"
    #pm.vm.provision "shell", inline: "cd /etc/puppet; sudo -u puppet -H r10k deploy environment -pv"
    #pm.vm.provision "shell", inline: "puppet module install theforeman-foreman_proxy"

    pm.vm.network "private_network", ip: "172.28.128.20"
  end

  config.vm.define "puppetdb" do |puppetdb|
    puppetdb.vm.hostname = "puppetdb.localdomain"

    puppetdb.vm.provision "shell", path:   "scripts/envsetup.sh"
    puppetdb.vm.provision "shell", path:   "scripts/puppet.sh"
    puppetdb.vm.provision "shell", inline: "puppet apply /vagrant/scripts/local-hosts.pp"
    puppetdb.vm.provision "shell", inline: "puppet module install theforeman-puppet"
    puppetdb.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-agent-install.pp"
    puppetdb.vm.provision "shell", inline: "sleep 30"
    puppetdb.vm.provision "shell", inline: "puppet agent -t --waitforcert 120"
    puppetdb.vm.provision "shell", inline: "puppet module install puppetlabs-puppetdb"
    puppetdb.vm.provision "shell", inline: "puppet apply /vagrant/scripts/puppetdb.pp"
 
    puppetdb.vm.network "private_network", ip: "172.28.128.21"
    puppetdb.vm.network "forwarded_port", guest: 8080, host: 8080
  end

  config.vm.define "foreman" do |foreman|
    foreman.vm.hostname = "foreman.localdomain"

    foreman.vm.provision "shell", path:   "scripts/envsetup.sh"
    foreman.vm.provision "shell", path:   "scripts/puppet.sh"
    foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/local-hosts.pp"
    foreman.vm.provision "shell", inline: "yum -y install http://yum.theforeman.org/releases/1.5/el6/x86_64/foreman-release.rpm"
    foreman.vm.provision "shell", inline: "yum -y install centos-release-SCL"
    foreman.vm.provision "shell", inline: "yum -y install foreman-installer"
    foreman.vm.provision "shell", inline: "puppet module install theforeman-puppet"
    foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-agent-install.pp"
    foreman.vm.provision "shell", inline: "sleep 30"
    foreman.vm.provision "shell", inline: "puppet agent -t --waitforcert 120"
    foreman.vm.provision "shell", inline: "echo 'foreman-installer --puppet-server=false --foreman-proxy-puppetrun=false --foreman-proxy-puppetca=false -v' > /root/foreman.sh; chmod +x /root/foreman.sh"

    foreman.vm.network "private_network", ip: "172.28.128.22"
    foreman.vm.network "forwarded_port", guest: 80,  host: 8081
    foreman.vm.network "forwarded_port", guest: 443, host: 8443
  end

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
