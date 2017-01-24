## The setting below accepts what will become the default
Package {  allow_virtual => true, }

host { 'localhost':
  ip           => '127.0.0.1',
  host_aliases => [ $::hostname,
                    'localhost', 'localhost.localdomain',
                    'localhost4', 'localhost4.localdomain4' ],
}

host { 'proxy.localdomain':
  ip           => '172.28.128.20',
  host_aliases => [
    'puppet',
    'puppet.localdomain',
  ],
}

host { 'foreman.localdomain':
  ip => '172.28.128.22',
}

host { 'client.localdomain':
  ip => '172.28.128.23',
}
