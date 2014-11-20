# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "genebean/centos6-64bit"  

  
  config.vm.define "foreman" do |foreman|
    foreman.vm.hostname = "foreman.localdomain"

	foreman.vm.provision "shell", inline: "yum clean all"
	foreman.vm.provision "shell", inline: "yum -y install http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm"
	foreman.vm.provision "shell", inline: "yum -y install http://yum.theforeman.org/releases/latest/el6/x86_64/foreman-release.rpm"
	foreman.vm.provision "shell", inline: "yum -y install foreman-installer"
	
	foreman.vm.provision "shell", inline: "foreman-installer --foreman-repo=stable  --foreman-passenger-interface='' \
	  --foreman-locations-enabled=true --foreman-initial-location=Staging --enable-foreman-compute-vmware --enable-foreman-plugin-bootdisk \
	  --enable-foreman-plugin-default-hostgroup --enable-foreman-plugin-discovery --enable-foreman-plugin-hooks \
	  --enable-foreman-plugin-puppetdb --enable-foreman-plugin-setup --enable-foreman-plugin-tasks "
#	  --foreman-foreman-url='https://foreman.westga.edu' --foreman-passenger-interface=eth1"

    foreman.vm.provision "shell", inline: "echo '*.localdomain' > /etc/puppet/autosign.conf"
    foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/local-hosts.pp"

    foreman.vm.provision "shell", inline: "puppet module install theforeman-puppet"
    foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-agent-install.pp"

    foreman.vm.network "private_network", ip: "172.28.128.22"
    foreman.vm.network "forwarded_port", guest: 80,  host: 8082
    foreman.vm.network "forwarded_port", guest: 443, host: 8443
  end
  
  
  config.vm.define "pm" do |pm|
    pm.vm.hostname = "pm.localdomain"

	pm.vm.provision "shell", inline: "yum clean all"
	pm.vm.provision "shell", inline: "yum -y install http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm"
	pm.vm.provision "shell", inline: "yum -y install http://yum.theforeman.org/releases/1.6/el6/x86_64/foreman-release.rpm"
	pm.vm.provision "shell", inline: "yum -y install foreman-installer"
	pm.vm.provision "shell", inline: "mkdir -p /var/lib/puppet/ssl/{certs,private_keys,public_keys}"
    pm.vm.provision "shell", inline: "cp /vagrant/scripts/ssl/certs/ca.pem /var/lib/puppet/ssl/certs/"
	pm.vm.provision "shell", inline: "for d in certs private_keys public_keys; do cp /vagrant/scripts/ssl/$d/pm.localdomain.pem /var/lib/puppet/ssl/$d/; done"
	pm.vm.provision "shell", path:   "scripts/puppet.sh"
    pm.vm.provision "shell", inline: "puppet apply /vagrant/scripts/local-hosts.pp"
	pm.vm.provision "shell", inline: "foreman-installer \
      --no-enable-foreman \
      --no-enable-foreman-cli \
      --no-enable-foreman-plugin-bootdisk \
      --no-enable-foreman-plugin-setup \
      --enable-puppet \
      --puppet-server-ca=false \
	  --puppet-ca-server=foreman.localdomain \
      --puppet-server-foreman-url=https://foreman.localdomain \
      --enable-foreman-proxy \
      --foreman-proxy-puppetca=false \
      --foreman-proxy-tftp=false \
      --foreman-proxy-foreman-base-url=https://foreman.localdomain \
      --foreman-proxy-trusted-hosts=foreman.localdomain \
      --foreman-proxy-oauth-consumer-key=YourKeyHere \
	  --foreman-proxy-oauth-consumer-secret=YourSecretHere"
	
    pm.vm.provision "shell", inline: "puppet module install theforeman-puppet"
    pm.vm.provision "shell", path:   "scripts/copy-files.sh"
    pm.vm.provision "shell", path:   "scripts/hieradata.sh"
    pm.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-master-1.pp"
    pm.vm.provision "shell", path:   "scripts/r10k-module.sh"
    pm.vm.provision "shell", inline: "puppet apply /vagrant/scripts/r10k_installation.pp --test --verbose; echo 'Finished installing r10k.'"
    pm.vm.provision "shell", inline: "cd /etc/puppet; sudo -u puppet -H r10k deploy environment -pv"

    pm.vm.network "private_network", ip: "172.28.128.20"
  end

  
  config.vm.define "puppetdb" do |puppetdb|
    puppetdb.vm.hostname = "puppetdb.localdomain"

    puppetdb.vm.provision "shell", path:   "scripts/puppet.sh"
    puppetdb.vm.provision "shell", inline: "puppet apply /vagrant/scripts/local-hosts.pp"
    puppetdb.vm.provision "shell", inline: "puppet module install theforeman-puppet"
    puppetdb.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-agent-install.pp"
    puppetdb.vm.provision "shell", inline: "echo 'sleeping for a minute...'; sleep 60"
    puppetdb.vm.provision "shell", inline: "puppet agent -t --waitforcert 120"
#    puppetdb.vm.provision "shell", inline: "puppet module install puppetlabs-puppetdb"
#    puppetdb.vm.provision "shell", inline: "puppet apply /vagrant/scripts/puppetdb.pp"
 
    puppetdb.vm.network "private_network", ip: "172.28.128.21"
    puppetdb.vm.network "forwarded_port", guest: 8080, host: 8080
    puppetdb.vm.network "forwarded_port", guest: 8081, host: 8081
  end

  
  config.vm.define "client" do |client|
    client.vm.hostname = "client.localdomain"

	client.vm.provision "shell", inline: "yum clean all"
	client.vm.provision "shell", inline: "yum -y install http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm"
    client.vm.provision "shell", path:   "scripts/puppet.sh"
    client.vm.provision "shell", inline: "puppet apply /vagrant/scripts/local-hosts.pp"
    client.vm.provision "shell", inline: "puppet module install theforeman-puppet"
    client.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-agent-install.pp"
  
    client.vm.network "private_network", ip: "172.28.128.23"
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
