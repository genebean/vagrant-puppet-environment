#!/bin/bash

## get foreman running
## re-run "puppet apply /vagrant/scripts/bootstrap-agent-install.pp" on the foreman node
## build module to install and setup the foreman-proxy on the puppet master
## 
## run this script to connect the puppet master to puppetdb and foreman

puppet module install puppetlabs-puppetdb
puppet apply /vagrant/scripts/bootstrap-master-2.pp
