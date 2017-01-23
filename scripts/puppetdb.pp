## The setting below accepts what will become the default
Package {  allow_virtual => true, }

class { '::puppetdb':
  listen_address     => '0.0.0.0',
  ssl_listen_address => '0.0.0.0',
  manage_firewall    => false,
}
