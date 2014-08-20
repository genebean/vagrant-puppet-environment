host {"$::hostname.uwg.westga.edu":
  ip             => '127.0.0.1',
  host_aliases   => [ "$::hostname", 'localhost', 
                      'localhost.localdomain', 'localhost4', 
                     'localhost4.localdomain4', ],
}
