class { '::puppet':
  pluginsync   => true,
  runmode      => 'service',
  agent        => true,
  puppetmaster => 'pm.localdomain',
}