## The setting below accepts what will become the default
Package {  allow_virtual => true, }

file { '/var/cache/r10k':
  ensure            => directory,
  owner             => 'puppet',
  group             => 'puppet',
}

class { 'r10k':
  configfile                => '/etc/puppet/r10k.yaml',
  configfile_symlink        => '/etc/r10k.yaml',
  manage_configfile_symlink => true,
  manage_modulepath         => false,
  purgedirs                 => ["${::settings::confdir}/environments"],
  sources                   => {
    'gitlab' => {
      'remote'  => 'git@code.westga.edu:puppet-config/puppet-environments.git',
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => false,
    }
  },
  
  require           => File['/var/cache/r10k'],
}

