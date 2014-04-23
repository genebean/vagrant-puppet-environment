node 'uwg-dw01' {
  include degreeworks

  class {'apache':
    default_vhost     => false,
  }

  ::apache::vhost { 'default-vhost':
    #ip              => '10.10.5.44'
    port            => 80,
    priority        => '00',
    docroot         => '/var/www/degreeworks',
    options         => [ '-Indexes', 'FollowSymLinks' ],
  }

  ::apache::vhost { 'default-ssl-vhost':
    #ip              => '10.10.5.44'
    port            => 443,
    priority        => '00',
    docroot         => '/var/www/degreeworks',
    options         => [ '-Indexes', 'FollowSymLinks' ],
    ssl             => true,
    ssl_protocol    => '-ALL +SSLv3 +TLSv1',
    ssl_cipher      => 'HIGH:MEDIUM:RC4+RSA:!LOW:!SSLv2:!TLSv1!aNULL:!MD5:!EXPORT',
  }
}
