#------------------------------------------------------------------------------
# Class: hosts
#------------------------------------------------------------------------------
class hosts {

    Class['hosts'] { stage => 'pre' }

    host {

        'localhost':
            ensure       => present,
            ip           => '127.0.0.1',
            host_aliases => 'localhost.localdomain';

        'puppet':
            ensure       => present,
            ip           => extlookup('host/puppet'),
            host_aliases => "puppet.${::domain}";
    }
}
