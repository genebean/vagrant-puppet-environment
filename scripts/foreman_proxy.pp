## The setting below accepts what will become the default
Package {  allow_virtual => true, }

class { 'foreman_proxy':
  version         => 'latest',
  ssl             => true,
  trusted_hosts   => [ 'foreman.localdomain', ],
  manage_sudoersd => true,
  use_sudoersd    => true,
  puppetca        => true,
  puppetrun       => true,
  tftp            => false,
  dhcp            => false,
  dhcp_managed    => false,
  dns             => false,
  dns_managed     => false,
  bmc             => false,
  realm           => false,
  
}

