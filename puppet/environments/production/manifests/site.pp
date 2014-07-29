node 'puppetmaster01' {
  class { 'puppet::master':
    environments  => 'directory',
    reports       => 'log,store',
    storeconfigs  => false,
    puppet_ssldir => '/etc/puppet/ssl',
    certname      => 'puppet',
    dns_alt_names => [ 'puppet.westga.edu',
                       'puppet.uwg.westga.edu',
                       'puppetmaster01.westga.edu',
                       'puppetmaster01.uwg.westga.edu',
                       'puppetmaster02.westga.edu',
                       'puppetmaster02.uwg.westga.edu', ],
    pluginsync    => true,
  }
  class { 'puppet::agent':
    puppet_server => 'puppet.westga.edu',
    environment   => 'production',
  }
}
