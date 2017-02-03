## The setting below accepts what will become the default
Package {  allow_virtual => true, }

class { '::puppet':
  pluginsync                    => true,
  runmode                       => 'service',
  ca_server                     => 'foreman.localdomain',

  agent                         => true,
  puppetmaster                  => 'foreman.localdomain',

  server                        => true,
  server_ca                     => true,
  server_implementation         => 'puppetserver',
  server_jvm_max_heap_size      => '768m',
  server_jvm_min_heap_size      => '768m',
  server_reports                => 'foreman,puppetdb',
  server_external_nodes         => '/etc/puppetlabs/puppet/node.rb',
  server_dynamic_environments   => false,
  server_directory_environments => true,
  server_environments           => [ ],
  server_environments_owner     => 'puppet',
  server_environments_group     => 'puppet',
  server_envs_dir               => '/etc/puppetlabs/code/environments',
  server_common_modules_path    => [
    '/etc/puppetlabs/code/environments/common',
    '/etc/puppetlabs/code/modules',
    '/opt/puppetlabs/puppet/modules',
  ],
  server_certname               => 'foreman.localdomain',

  server_service_fallback       => false,
  server_foreman_url            => 'https://foreman.localdomain',
  server_foreman_ssl_ca         => '/etc/puppetlabs/puppet/ssl/ca/ca_crt.pem',
  server_foreman_ssl_cert       => '/etc/puppetlabs/puppet/ssl/certs/foreman.localdomain.pem',
  server_foreman_ssl_key        => '/etc/puppetlabs/puppet/ssl/private_keys/foreman.localdomain.pem',
  #server_enc_api                => 'v2',
  #server_report_api             => 'v2',
}

class { '::puppetdb':
  database_port   => '55432',
  manage_firewall => false,
  #manage_package_repo => false,
}

class { '::puppetdb::master::config':
  manage_storeconfigs     => false,
  manage_report_processor => false,
}
