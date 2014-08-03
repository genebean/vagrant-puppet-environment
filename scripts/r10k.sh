#!/bin/bash

# r10k setup
if [ ! -d '/etc/puppet/environments' ]; then
  mkdir -p /etc/puppet/environments
fi

echo 'Installing the r10k module'
puppet module install zack-r10k
