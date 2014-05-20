node 'uwg-dw01' {
  include degreeworks
  include oracledb

  class {'apache':
    default_vhost   => false,
  }

  $httpoptions = [ 'Indexes', 'FollowSymLinks', 'ExecCGI' ]
  $dwhandlers  = [{ handler => 'cgi-script', extensions => ['.cgi']}]

  ::apache::vhost { 'default-vhost':
    #ip              => '10.10.5.44'
    port            => 80,
    priority        => '00',
    docroot         => '/var/www/degreeworks',
    options         => $httpoptions,
    directories     => [
      { path           => '/var/www/degreeworks',
        addhandlers    => $dwhandlers,
        directoryindex => 'default.html',

        allow_override => ['All'],
        order          => 'Allow,Deny',
        allow          => 'from all',
      },
    ],
  }

  ::apache::vhost { 'default-ssl-vhost':
    #ip              => '10.10.5.44'
    port            => 443,
    priority        => '00',
    docroot         => '/var/www/degreeworks',
    options         => $httpoptions,
    directories     => [
      { path           => '/var/www/degreeworks',
        addhandlers    => $dwhandlers,
        directoryindex => 'default.html',

        allow_override => ['All'],
        order          => 'Allow,Deny',
        allow          => 'from all',
      },
    ],

    ssl             => true,
    ssl_protocol    => 'All -SSLv2',
    ssl_cipher      => 'ALL:!ADH:!EXPORT:!SSLv2:RC4+RSA:+HIGH:+MEDIUM:+LOW',
  }
}

node 'dev01.www.westga.edu' {
  ::network::if::static { 'eth1':
    ensure          => 'up',
    macaddress      => '00:50:56:8E:12:64',
    ipaddress       => '10.10.5.47',
    netmask         => '255.255.255.0',
  }
}

node 'prd01.www.westga.edu' {
  ::network::if::static { 'eth1':
    ensure          => 'up',
    macaddress      => '00:50:56:8E:2A:63',
    ipaddress       => '10.10.5.48',
    netmask         => '255.255.255.0',
  }
}

node 'dev01.staff.westga.edu' {
  ::network::if::static { 'eth1':
    ensure          => 'up',
    macaddress      => '00:50:56:8e:59:f9',
    ipaddress       => '10.10.5.49',
    netmask         => '255.255.255.0',
  }
}

node 'dev01.webapps.westga.edu' {
  ::network::if::static { 'eth1':
    ensure          => 'up',
    macaddress      => '00:50:56:8e:38:1c',
    ipaddress       => '10.10.5.50',
    netmask         => '255.255.255.0',
  }
}

node 'dev01.cms.westga.edu' {
  ::network::if::static { 'eth1':
    ensure          => 'up',
    macaddress      => '00:50:56:8e:02:16',
    ipaddress       => '10.10.5.51',
    netmask         => '255.255.255.0',
  }

  class {'apache':
    default_vhost   => false,
    default_mods    => false,
    mpm_module      => 'prefork',
    servername      => 'dev01.cms.westga.edu',
  }

  $httpoptions = [ '-Indexes', 'FollowSymLinks' ]

  ::apache::vhost { 'default-vhost':
    ip              => '10.10.5.51',
    port            => 80,
    priority        => '00',
    docroot         => '/var/www/html',
    options         => $httpoptions,
    directories     => [
      { path           => '/var/www/html',
        directoryindex => 'index.html index.htm index.php',

        allow_override => ['All'],
        order          => 'Allow,Deny',
        allow          => 'from all',
      },
    ],
  }

  ::apache::vhost { 'default-ssl-vhost':
    ip              => '10.10.5.51',
    port            => 443,
    priority        => '00',
    docroot         => '/var/www/html',
    options         => $httpoptions,
    directories     => [
      { path           => '/var/www/html',
        directoryindex => 'index.html index.htm index.php',

        allow_override => ['All'],
        order          => 'Allow,Deny',
        allow          => 'from all',
      },
    ],

    ssl             => true,
    ssl_protocol    => 'All -SSLv2',
    ssl_cipher      => 'ALL:!ADH:!EXPORT:!SSLv2:RC4+RSA:+HIGH:+MEDIUM:+LOW',
  }

  include apache::mod::php
  class {'apache::mod::info':
    #restrict_access => false,
    allow_from      => [
      '160.10.36', 
      '160.10.38', 
      '127.0.0.1',
    ],
  }

  class { 'apache::mod::ssl':
    ssl_compression => false,
    ssl_options     => [ 'StdEnvVars' ],
  }

}

node 'dogpile' {
  include ::base
}

node 'xander.westga.info' {
  # This is our Linode.
  # It will be a Zabbix server and run Nginx / PHP.
  # It will also have a local Postfix server setupto send notices.
  # This node also has IPv6 enabled so some things will need to be adjusted
  #  so as not to break this.
}
