## The setting below accepts what will become the default
Package {  allow_virtual => true, }

class { '::puppetdb::master::config':
  puppetdb_server         => 'puppetdb.localdomain',
  manage_storeconfigs     => false,
  manage_report_processor => false,
  puppet_service_name     => 'httpd',
}
