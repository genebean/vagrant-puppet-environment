class { '::puppet':
  pluginsync                    => true,
  runmode                       => 'none',
  dns_alt_names                 => [ 'puppetdb', ],

  agent                         => true,
  puppetmaster                  => 'pm.localdomain',
}
class { 'puppetdb':
  listen_address => '0.0.0.0',
  ssl_listen_address => '0.0.0.0',
}
