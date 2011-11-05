#------------------------------------------------------------------------------
# Class: puppet-server::service
#
#   This class is part of the puppet-server module.
#   You should not be calling this class.
#   The delegated class is Class['puppet-server'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-05
#
#------------------------------------------------------------------------------
class puppet-server::service ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !( $ensure in [ 'running', 'stopped' ] ) { fail("${module_name}::service 'ensure' must be one of: 'running' or 'stopped'") }

    # Start or stop the service:
    service { $puppet-server::params::service_name:
        ensure  => $ensure,
        enable  => $ensure ? {
            'running' => true,
            'stopped' => false,
        }
    }
}
