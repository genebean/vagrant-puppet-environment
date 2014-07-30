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
}