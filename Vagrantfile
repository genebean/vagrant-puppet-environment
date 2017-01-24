# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "genebean/centos-7-puppet-agent"

  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box
  end

  config.vm.define "foreman" do |foreman|
    foreman.vm.hostname = "foreman.localdomain"

    foreman.vm.provision "shell", inline: "systemctl restart network"
  	foreman.vm.provision "shell", inline: "yum clean all"
  	foreman.vm.provision "shell", inline: "rpm -ivh --replacepkgs https://yum.theforeman.org/releases/1.14/el7/x86_64/foreman-release.rpm"
  	foreman.vm.provision "shell", inline: "yum -y install foreman-installer"

    # --foreman-foreman-url='https://foreman.westga.edu' --foreman-passenger-interface=eth1
    # --foreman-server-ssl-cert --foreman-server-ssl-chain --foreman-server-ssl-key Defines Apache mod_ssl cert files.
  	foreman.vm.provision "shell", inline: <<-EOF
      until foreman-installer --foreman-admin-password='password' \
        --puppet-server-implementation='puppetserver' \
        --puppet-server-jvm-max-heap-size='768m' --puppet-server-jvm-min-heap-size='768m' \
        --enable-foreman-compute-vmware --enable-foreman-plugin-bootdisk \
    	  --enable-foreman-plugin-default-hostgroup --enable-foreman-plugin-hooks \
        --enable-foreman-plugin-setup --enable-foreman-plugin-tasks \
    	  --enable-foreman-plugin-puppetdb \
        --foreman-plugin-puppetdb-address='https://localhost:8081/pdb/cmd/v1' \
        --foreman-plugin-puppetdb-dashboard-address='http://localhost:8080/pdb/dashboard' \
        --foreman-proxy-realm=false
      do
        echo 'Foreman install failed, running it again.'
      done
    EOF

    foreman.vm.provision "shell", inline: "echo '*.localdomain' > /etc/puppetlabs/puppet/autosign.conf"
    foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/local-hosts.pp"

    foreman.vm.provision "shell", inline: "puppet module install theforeman-puppet"
    foreman.vm.provision "shell", inline: "puppet module install theforeman-foreman"
    foreman.vm.provision "shell", inline: "puppet module install puppetlabs-puppetdb"
    foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-master-1.pp"
    foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-master-2.pp"

    # TODO: Hiera and r10k setup
    # foreman.vm.provision "shell", path:   "scripts/copy-files.sh"
    # foreman.vm.provision "shell", path:   "scripts/hieradata.sh"
    # foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-master-1.pp"
    # foreman.vm.provision "shell", path:   "scripts/r10k-module.sh"
    # foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/r10k_installation.pp --test --verbose; echo 'Finished installing r10k.'"
    # foreman.vm.provision "shell", inline: "cd /etc/puppet; sudo -u puppet -H r10k deploy environment -pv"

    foreman.vm.network "private_network", ip: "172.28.128.22"
    
    foreman.vm.provider :virtualbox do |vb|
          vb.customize ["modifyvm", :id, "--memory", "2048"]
          vb.customize ["modifyvm", :id, "--cpus", "2"]
      end
  end


  config.vm.define "proxy" do |proxy|
    proxy.vm.hostname = "proxy.localdomain"

    proxy.vm.provision "shell", inline: "systemctl restart network"
    proxy.vm.provision "shell", inline: "puppet apply /vagrant/scripts/local-hosts.pp"
    proxy.vm.provision "shell", inline: "puppet module install theforeman-puppet"
    proxy.vm.provision "shell", inline: "puppet module install puppetlabs-haproxy"
    proxy.vm.provision "shell", inline: "puppet apply /vagrant/scripts/proxy.pp"
    proxy.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-agent-install.pp"

    proxy.vm.network "private_network", ip: "172.28.128.20"
    proxy.vm.network "forwarded_port", guest: 443, host: 8443
    proxy.vm.network "forwarded_port", guest: 8081, host: 8081
    proxy.vm.network "forwarded_port", guest: 9000, host: 9000
  end

  config.vm.define "client" do |client|
    client.vm.hostname = "client.localdomain"

    client.vm.provision "shell", inline: "systemctl restart network"
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

end
