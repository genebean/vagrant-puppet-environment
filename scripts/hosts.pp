## The setting below accepts what will become the default
Package {  allow_virtual => true, }

host { 'pm.localhost':
  ip => '172.28.128.20',
}

host { 'puppetdb.localhost':
  ip => '172.28.128.21',
}

host { 'foreman.localhost':
  ip => '172.28.128.22',
}

