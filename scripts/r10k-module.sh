#!/bin/bash

puppet module install puppetlabs-gcc
puppet module install puppetlabs-inifile
puppet module install puppetlabs-ruby
puppet module install puppetlabs-vcsrepo
puppet module install --ignore-dependencies zack-r10k
