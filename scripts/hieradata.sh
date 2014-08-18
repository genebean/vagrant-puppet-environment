#!/bin/bash

cd /etc/puppet
if [ ! -d '/etc/puppet/hieradata' ]; then
  sudo -u puppet -H git clone git@code.westga.edu:puppet-config/hieradata.git /etc/puppet/hieradata
else
  cd hieradata
  sudo -u puppet -H git pull
  cd ..
fi

echo 'Install gems used by hiera'
gem install hiera-eyaml --no-rdoc --no-ri
gem install hiera-file --no-rdoc --no-ri
