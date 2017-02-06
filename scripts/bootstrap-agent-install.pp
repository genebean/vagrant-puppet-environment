## The setting below accepts what will become the default
Package {  allow_virtual => true, }

class { '::puppet':
  pluginsync   => true,
  runmode      => 'service',
  agent        => true,
  puppetmaster => 'puppet.localdomain',
  ca_server    => 'puppet.localdomain',
}
