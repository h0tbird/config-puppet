#------------------------------------------------------------------------------
# Class: ntp::service
#
#   This class is part of the ntp module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-05-15
#
#------------------------------------------------------------------------------
class ntp::service ( $ensure ) {

    # Require the delegated class:
    Class["${module_name}"] -> Class["${module_name}::service"]

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
