## The setting below accepts what will become the default
Package {  allow_virtual => true, }

class { '::puppet':
  pluginsync                    => true,
  runmode                       => 'none',
  dns_alt_names                 => [ 'foreman', ],

  agent                         => true,
  puppetmaster                  => 'pm.localdomain',
}

