class { 'r10k':
  manage_modulepath => false,
  purgedirs         => ["${::settings::confdir}/environments"],
  sources           => {
    'gitlab' => {
      'remote'  => 'git@code.westga.edu:puppet-config/puppet-environments.git',
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => false,
    }
  },
  
  require           => File['/var/cache/r10k'],
}

file { '/var/cache/r10k':
  ensure            => directory,
  owner             => 'puppet',
  group             => 'puppet',
}

file { '/etc/puppet/environments':
  owner             => 'puppet',
  group             => 'puppet',
  recurse           => true,
}
