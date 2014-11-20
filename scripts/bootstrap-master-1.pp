## The setting below accepts what will become the default
Package {  allow_virtual => true, }

class { '::puppet':
  pluginsync                    => true,
  runmode                       => 'service',
  ca_server                     => 'foreman.localdomain',
  #dns_alt_names                 => [ 'puppet', 'puppet.westga.edu', 'puppet.uwg.westga.edu',
  #                                   'puppetmaster01.westga.edu', 'puppetmaster01.uwg.westga.edu',
  #                                   'puppetmaster02.westga.edu', 'puppetmaster02.uwg.westga.edu' ],

  agent                         => true,
  puppetmaster                  => 'pm.localdomain',

  server                        => true,
  server_ca                     => false,
  server_reports                => 'foreman',
  server_passenger              => true,
  server_external_nodes         => '/etc/puppet/node.rb',
  server_dynamic_environments   => false,
  server_directory_environments => true,
  server_environments           => [ ],
  server_environments_owner     => 'puppet',
  server_environments_group     => 'puppet',
  server_envs_dir               => '/etc/puppet/environments',
  server_common_modules_path    => [ '/etc/puppet/modules', ],
  server_certname               => 'pm.localdomain',

  server_service_fallback       => false,
  server_passenger_max_pool     => 4, #default is 12
  server_foreman_url            => 'https://foreman.localdomain',
  server_foreman_ssl_ca         => '/var/lib/puppet/ssl/certs/ca.pem',
  server_foreman_ssl_cert       => '/var/lib/puppet/ssl/certs/pm.localdomain.pem',
  server_foreman_ssl_key        => '/var/lib/puppet/ssl/private_keys/pm.localdomain.pem',
  server_enc_api                => 'v2',
  server_report_api             => 'v2',
  
}
