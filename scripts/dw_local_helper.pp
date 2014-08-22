Package {  allow_virtual => true, }

$groups = [ 'oinstall', 'DegreeWorksAdmins', 'dba', ]
$gems   = [ 'hiera-eyaml', 'hiera-file', ]

package { $gems:
  ensure     => present,
  provider   => gem,
}

## need to make sure this is done on non-local systems...
file { '/home/UWG':
  ensure     => directory,
  mode       => '0755',
  owner      => 'root',
  group      => 'root',
}

package { 'mksh':
  ensure     => present,
}

user { 'dwadmin':
  ensure     => present,
  home       => '/home/UWG/dwadmin',
  managehome => true,
  #password   => 'Puppet-is-my-friend',
  password   => '$6$salt$C.wae.m0tp6SNY/T7YllHOGwzEzGy3c9m7gGVbNEzpxjn0tdx./EGK4t9dA4Y0UZUKXRaNdNMuBcBP8qG0zsK0',
  shell      => '/bin/ksh',
  require    => [ File['/home/UWG'],
                  Package['mksh'], ]
}

user { 'oracle':
  ensure     => present,
  home       => '/home/UWG/oracle',
  groups     => [ 'oinstall', 'dba', ],
  managehome => true,
  #password   => 'Puppet-is-my-friend',
  password   => '$6$salt$C.wae.m0tp6SNY/T7YllHOGwzEzGy3c9m7gGVbNEzpxjn0tdx./EGK4t9dA4Y0UZUKXRaNdNMuBcBP8qG0zsK0',
  require    => File['/home/UWG'],
}

group { $groups:
  ensure     => present,
}

# temp entry until oracle is setup
file { '/tmp/ojdbc6.jar':
  ensure     => present,
  content    => "blah\n",
}
