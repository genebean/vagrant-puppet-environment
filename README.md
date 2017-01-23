# UWG Puppet Master Repo

This repo has everything needed to setup a Puppet Master including the files needed to run one in Vagrant.

## Version

0.2 - Redo based on Foreman 1.6
0.1 - Design phase

### ToDo List:

1. Implement a method to keep the Hiera data up-to-date (vcsrepo module)
2. Automate foreman-proxy setup
3. When does r10k get run on pm? (via provided web hook... need to set this up still)
4. Implement the eyaml backend for Hiera and move sensitive data into it.
5. Design a method for EApps / Web Team people to author data

## Installing for development / testing

To fully use the development environment you will need to have [Vagrant] and [Git]
installed. The first time you run `vagrant up` it will take a few minutes to download
the [box] (virtual machine template). This is a one-time thing. The box specified in
the Vagrantfile supports [Virtualbox], [VMware Workstation], and [VMware Fusion].

The setps below need to be followed in order to prevent problems from cropping up.
```sh
git clone git@code.westga.edu:puppet-config/puppet-master.git  
cd puppet-master
```

### The Foreman (ENC, CA, and report processor)

```sh
vagrant up foreman
```

From host computer, go to https://127.0.0.1:8443 and log in the name and password
output by the installer. Change the admin password to something that can be remembered.

```sh
vagrant ssh foreman
sudo -s
puppet cert generate pm.localdomain
cp /var/lib/puppet/ssl/certs/ca.pem /vagrant/scripts/ssl/certs/
for d in certs private_keys public_keys; do cp -f /var/lib/puppet/ssl/$d/pm.localdomain.pem /vagrant/scripts/ssl/$d/; done
```

### Update Vagrantfile for this install

Use the oauth_consumer_key / oauth_consumer_secret from Forman Settings -> Auth as the
last two entries in the installer. This auto-registers the Puppet Master with Foreman.

### Puppet Master
```sh
vagrant up pm
```

### PuppetDB
```sh
vagrant up puppetdb
```

At this point you need to go into The Foreman and apply `puppetlabs-puppetdb` to puppetdb.localdomain.
Be sure that `listen_address` and `ssl_listen_address` are set to use the proper adderess if 0.0.0.0 is
not what you want. I suggest setting this in Hiera. After this run:

```sh
puppet agent -t # setups up PuppetDB via the assigned modules
```

From your computer, go to http://127.0.0.1:8080 and make sure a dashboard shows up. Once it does,
go back to Foreman and add the `puppetdb::master::config` module with the following settings:

```yml
puppetdb_server: puppetdb.localdomain
puppet_service_name: httpd
```

Once those settings apply successfully you will need to go back over to pm.localdomain and run:

```sh
puppet apply /vagrant/scripts/bootstrap-master-2.pp
```

This makes the Puppet Master use PuppetDB for stored configs and as a report processor.

## Installing on a vSphere VM

```sh
TODO: document this...
```

## Tech

Our Puppet Master is made up of several components and takes advantage of several
other open source projects:

* [Foreman] - a complete lifecycle management tool for physical and virtual servers.
* [Git] - version control
* [Puppet] - automated configuration managment.
* [PuppetDB] - a data warehouse for Puppet.
* [Puppet Forge] - a central repo for Puppet modules
* [r10k] - a tool for deploying Puppet Environments
* [Vagrant] - light weight, reproducible, and portable development environments
* [Virtualbox] - free way to run vm's like those used as part of Vagrant


[box]:https://vagrantcloud.com/genebean/centos6-64bit
[Foreman]:http://theforeman.org/
[Git]:http://git-scm.com/
[Puppet]:http://docs.puppetlabs.com/guides/install_puppet/pre_install.html
[PuppetDB]:https://docs.puppetlabs.com/puppetdb/
[Puppet Forge]:https://forge.puppetlabs.com/
[r10k]:https://github.com/adrienthebo/r10k
[Vagrant]:http://www.vagrantup.com/
[Virtualbox]:https://www.virtualbox.org/wiki/Downloads
[VMware Fusion]:http://www.vmware.com/products/fusion/
[VMware Workstation]:http://www.vmware.com/products/workstation/
