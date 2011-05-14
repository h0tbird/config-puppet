#------------------------------------------------------------------------------
# ntp::service
#------------------------------------------------------------------------------

class ntp::service ( $ensure ) {

    # Require the delegated class:
    Class['ntp'] -> Class['ntp::service']

    # Check for valid values:
    if ! ( $ensure in [ 'running', 'stopped' ] ) {
        fail ( "${module_name}::service 'ensure' must be one of: 'running' or 'stopped'" )
    }

    # Start or stop the service:
    service { $ntp::params::service_name:
        ensure  => $ensure,
        enable  => $ensure ? {
            'running' => true,
            'stopped' => false,
        }
    }
}
