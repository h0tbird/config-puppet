#------------------------------------------------------------------------------
# Class: samba::service
#
#   This class is part of the samba module.
#   You should not be calling this class.
#   The delegated class is Class['samba'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-10
#
#------------------------------------------------------------------------------
class samba::service ( $ensure ) {

    # Deliberate cyclical dependency:
    require "${module_name}"

    # Check for valid values:
    if !( $ensure in [ 'running', 'stopped' ] ) { fail("${module_name}::service 'ensure' must be one of: 'running' or 'stopped'") }

    # Start or stop the service:
    service { $samba::params::service_name:
        ensure  => $ensure,
        enable  => $ensure ? {
            'running' => true,
            'stopped' => false,
        }
    }
}
