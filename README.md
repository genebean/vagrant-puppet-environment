# UWG Puppet Master Repo

This repo has everything needed to setup a Puppet Master including the files needed to run one in Vagrant.

## Version

0.1 - Design phase

### ToDo List:

1. Implement a method to keep the Hiera data up-to-date (vcsrepo module)
2. Automate foreman-proxy setup
3. Automate foreman install via a while loop and checking exit codes
4. When does r10k get run on pm?
5. Implement the eyaml backend for Hiera and move sensitive data into it.
6. Design a method for EApps / Web Team people to author data

## Installing for development / testing

To fully use the development environment you will need to have [Vagrant] and [Git]
installed. The first time you run `vagrant up` it will take a few minutes to download
the [box] (virtual machine template). This is a one-time thing. The box specified in 
the Vagrantfile supports [Virtualbox], [VMware Workstation], and [VMware Fusion].

```sh
git clone git@code.westga.edu:puppet-config/puppet-master.git  
cd puppet-master

# bring machines up in order one at a time

# Puppet Master
vagrant up pm

# PuppetDB
vagrant up puppetdb
# from host computer, go to http://127.0.0.1:8080 and make sure a dashboad shows up

# The Foreman (ENC and report processor)
vagrant up foreman
# from host computer, go to http://127.0.0.1:8081 and log in with admin / changeme

# configure foreman-proxy for pm <--> foreman communication
vagrant ssh pm
sudo -s
sh /vagrant/scripts/post-flight.sh
```

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

