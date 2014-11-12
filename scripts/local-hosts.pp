## The setting below accepts what will become the default
Package {  allow_virtual => true, }

host { 'localhost':
  ip           => '127.0.0.1',
  host_aliases => [ "$::hostname", 
                    'localhost', 'localhost.localdomain',
                    'localhost4', 'localhost4.localdomain4' ],
}

host { 'pm.localdomain':
  ip           => '172.28.128.20',
  host_aliases => 'puppet',
}

host { 'puppetdb.localdomain':
  ip           => '172.28.128.21',
}

host { 'foreman.localdomain':
  ip           => '172.28.128.22',
}

