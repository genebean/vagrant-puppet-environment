# Puppet Master Repo

This repo has everything needed to setup a Puppet environment in Vagrant. It
includes all the components that make up a complete system including load
balancer, Puppet Server, PuppetDB, Foreman, r10k, and PostgreSQL. It also
pulls down a sample control repo for Hiera, roles, and profiles.


## Version

2.0 - Redo for Puppet 4  
0.2 - Redo based on Foreman 1.6  
0.1 - Design phase  


## Installing for development / testing

To fully use the development environment you will need to have [Vagrant] and [Git]
installed. The first time you run `vagrant up` it will take a few minutes to download
the [box] (virtual machine template). This is a one-time thing. The box specified in
the Vagrantfile only supports [Virtualbox].


### Running this environment

```sh
cd [the location you cloned this repo]
vagrant up
```

 Once the setup is complete you will have an instance of [HAProxy]
 that fronts the web interface of Foreman. It also provides a metrics page for
 monitoring HAProxy's performance. The Foreman server will also be running
 Puppet Server and PuppetDB. PuppetDB's dashboard can be accessed from inside
 Foreman by going to `Monitor --> PuppetDB Dashboard`

 **URL's:**

 * *Foreman:* https://127.0.0.1:8443 user: `admin` password: `password`
 * *HAProxy Metrics:* http://127.0.0.1:9000 user: `admin` password: `password`

**Note:**

One thing of note is that the `site.pp` file in the control repo is used to
do the node classification during setup and will be applying settings
_outside_ of Foreman.

## Tech

Our Puppet Master is made up of several components and takes advantage of several
other open source projects:

* [Foreman] - a complete lifecycle management tool for physical and virtual servers.
* [Git] - version control
* [HAProxy] - a load balancer
* [Puppet] - automated configuration management.
* [PuppetDB] - a data warehouse for Puppet.
* [Puppet Forge] - a central repo for Puppet modules
* [r10k] - a tool for deploying Puppet Environments
* [Vagrant] - light weight, reproducible, and portable development environments
* [Virtualbox] - free way to run vm's like those used as part of Vagrant


[box]:https://vagrantcloud.com/genebean/centos6-64bit
[Foreman]:http://theforeman.org/
[Git]:http://git-scm.com/
[HAProxy]:http://www.haproxy.org/
[Puppet]:http://docs.puppetlabs.com/guides/install_puppet/pre_install.html
[PuppetDB]:https://docs.puppetlabs.com/puppetdb/
[Puppet Forge]:https://forge.puppetlabs.com/
[r10k]:https://github.com/adrienthebo/r10k
[Vagrant]:http://www.vagrantup.com/
[Virtualbox]:https://www.virtualbox.org/wiki/Downloads
[VMware Fusion]:http://www.vmware.com/products/fusion/
[VMware Workstation]:http://www.vmware.com/products/workstation/
