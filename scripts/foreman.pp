class { '::puppet':
  pluginsync                    => true,
  runmode                       => 'none',
  dns_alt_names                 => [ 'foreman', ],

  agent                         => true,
  puppetmaster                  => 'pm.localdomain',
}
