#------------------------------------------------------------------------------
# Class: samba::service
#
#   This class is part of the samba module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-10
#
#------------------------------------------------------------------------------
class samba::service ( $ensure ) {

    # Require the delegated class:
    Class["${module_name}"] -> Class["${module_name}::service"]

    # Check for valid values:
    if ! ( $ensure in [ 'running', 'stopped' ] ) {
        fail ( "${module_name}::service 'ensure' must be one of: 'running' or 'stopped'" )
    }

    # Start or stop the service:
    service { $samba::params::service_name:
        ensure  => $ensure,
        enable  => $ensure ? {
            'running' => true,
            'stopped' => false,
        }
    }
}
