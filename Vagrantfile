# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "genebean/centos-7-puppet5"

  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box
  end

  config.vm.define "proxy" do |proxy|
    proxy.vm.hostname = "proxy.localdomain"

    proxy.vm.provision "shell", inline: "systemctl restart network"
    proxy.vm.provision "shell", inline: "puppet apply /vagrant/scripts/local-hosts.pp"
    proxy.vm.provision "shell", inline: "puppet module install theforeman-puppet"
    proxy.vm.provision "shell", inline: "puppet module install puppetlabs-haproxy"
    proxy.vm.provision "shell", inline: "puppet apply /vagrant/scripts/proxy.pp"
    proxy.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-agent-install.pp"
    proxy.vm.provision "shell", inline: "rm -rf /etc/puppetlabs/code/environments/production/modules/*"
    proxy.vm.provision "shell", inline: "systemctl stop puppet"

    proxy.vm.network "private_network", ip: "172.28.128.10"
    proxy.vm.network "forwarded_port", guest:  443, host: 8443
    proxy.vm.network "forwarded_port", guest: 8081, host: 8081
    proxy.vm.network "forwarded_port", guest: 8888, host: 8888
    proxy.vm.network "forwarded_port", guest: 9000, host: 9000
  end

  config.vm.define "pg1" do |pg1|
    pg1.vm.hostname = "pg1.localdomain"

    pg1.vm.provision "shell", inline: "systemctl restart network"
    pg1.vm.provision "shell", inline: "yum clean all"
    pg1.vm.provision "shell", inline: "puppet apply /vagrant/scripts/local-hosts.pp"
    pg1.vm.provision "shell", inline: "puppet module install puppetlabs-puppetdb"
    pg1.vm.provision "shell", inline: "puppet apply /vagrant/scripts/pg1-setup.pp"
    pg1.vm.provision "shell", inline: "puppet module install theforeman-puppet"
    pg1.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-agent-install.pp"
    pg1.vm.provision "shell", inline: "rm -rf /etc/puppetlabs/code/environments/production/modules/*"
    pg1.vm.provision "shell", inline: "systemctl stop puppet"

    pg1.vm.network "private_network", ip: "172.28.128.21"
  end

  config.vm.define "foreman" do |foreman|
    foreman.vm.hostname = "foreman.localdomain"

    foreman.vm.provision "shell", inline: "systemctl restart network"
    foreman.vm.provision "shell", inline: "yum clean all"
    foreman.vm.provision "shell", inline: "rpm -ivh --replacepkgs https://yum.theforeman.org/nightly/el7/x86_64/foreman-release.rpm"
    foreman.vm.provision "shell", inline: "yum -y install foreman-installer"
    foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/local-hosts.pp"

    foreman.vm.provision "shell", inline: <<-EOF
      foreman-installer --foreman-admin-password='password' \
      --puppet-server-implementation='puppetserver' \
      --puppet-server-jvm-max-heap-size='768m' --puppet-server-jvm-min-heap-size='768m' \
      --enable-foreman-compute-vmware --enable-foreman-plugin-bootdisk \
      --enable-foreman-plugin-default-hostgroup --enable-foreman-plugin-hooks \
      --enable-foreman-plugin-setup --enable-foreman-plugin-tasks \
      --enable-foreman-plugin-puppetdb \
      --foreman-plugin-puppetdb-address='https://localhost:8081/pdb/cmd/v1' \
      --foreman-plugin-puppetdb-dashboard-address='http://localhost:8080/pdb/dashboard' \
      --foreman-proxy-realm=false \
      --foreman-db-type='postgresql' --foreman-db-database='foreman' --foreman-db-host='pg1.localdomain' \
      --foreman-db-manage=false --foreman-db-username='foremandbuser' --foreman-db-password='Y3ll0-h@t' \
      --puppet-dns-alt-names='puppet.localdomain' \
      --foreman-passenger-interface='172.28.128.20'
    EOF

    foreman.vm.provision "shell", inline: "echo '*.localdomain' > /etc/puppetlabs/puppet/autosign.conf"

    foreman.vm.provision "shell", inline: "puppet module install theforeman-puppet"
    foreman.vm.provision "shell", inline: "puppet module install theforeman-foreman"
    foreman.vm.provision "shell", inline: "puppet module install puppetlabs-puppetdb"
    foreman.vm.provision "shell", inline: "puppet module install puppet-r10k"
    foreman.vm.provision "shell", inline: "puppet module install puppet-hiera"
    foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-master-1.pp"
    foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-master-2.pp" # PupetDB setup
    foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-master-3.pp" # starts using PuppetDB
    foreman.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-master-4.pp" # adds r10k
    foreman.vm.provision "shell", inline: "/usr/bin/r10k deploy environment --puppetfile --verbose"
    foreman.vm.provision "shell", inline: "puppet agent -t || echo 'sleeping for a minute and trying again...'; sleep 60; puppet agent -t"
    foreman.vm.provision "shell", inline: "yum -y install sshpass"
    ssh_cmd = "sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no"
    foreman.vm.provision "shell", inline: "until #{ssh_cmd} pg1.localdomain 'puppet agent -t'; do echo 'running puppet again on pg1.localdomain'; done"
    foreman.vm.provision "shell", inline: "until #{ssh_cmd} proxy.localdomain 'puppet agent -t'; do echo 'running puppet again on proxy.localdomain'; done"

    foreman.vm.network "private_network", ip: "172.28.128.20"

    foreman.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "4096"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end
  end

  config.vm.define "client" do |client|
    client.vm.hostname = "client.localdomain"

    client.vm.provision "shell", inline: "systemctl restart network"
    client.vm.provision "shell", inline: "puppet apply /vagrant/scripts/local-hosts.pp"
    client.vm.provision "shell", inline: "puppet module install theforeman-puppet"
    client.vm.provision "shell", inline: "puppet apply /vagrant/scripts/bootstrap-agent-install.pp"
    client.vm.provision "shell", inline: "rm -rf /etc/puppetlabs/code/environments/production/modules/*"
    client.vm.provision "shell", inline: "puppet agent -t || echo 'skipping since Puppet is already running.'"

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
