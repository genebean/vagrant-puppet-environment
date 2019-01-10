## The setting below accepts what will become the default
class { '::puppetdb::database::postgresql':
  database_name     => 'puppetdb',
  database_username => 'puppetdbuser',
  database_password => 'Pupp3t-DB-V00D00',
  postgres_version  => '9.6',
  listen_addresses  => '*',
  # manage_package_repo => false,
}

::postgresql::server::db { 'foreman':
  user     => 'foremandbuser',
  password => postgresql_password('foremandbuser', 'Y3ll0-h@t'),
  owner    => 'foremandbuser',
  encoding => 'utf8',
  locale   => 'en_US.utf8',
}
