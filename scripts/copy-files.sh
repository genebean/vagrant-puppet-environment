#!/bin/bash

cp -f /vagrant/puppet/* /etc/puppet/

cp -r /vagrant/scripts/.ssh /var/lib/puppet/
chown -R puppet:puppet /var/lib/puppet/.ssh
chmod 0700 /var/lib/puppet/.ssh
chmod 0600 /var/lib/puppet/.ssh/id_rsa
chmod 0644 /var/lib/puppet/.ssh/id_rsa.pub
chmod 0644 /var/lib/puppet/.ssh/known_hosts
