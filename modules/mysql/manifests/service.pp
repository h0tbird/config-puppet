#------------------------------------------------------------------------------
# Class: mysql::service
#
#   This class is part of the mysql module.
#   You should not be calling this class.
#   The delegated class is Class['mysql'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-12-29
#
#------------------------------------------------------------------------------
class mysql::service ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !($ensure in [ running, stopped ]) { fail("${module_name}::service 'ensure' must be one of: 'running' or 'stopped'") }

    # Start or stop the service:
    service { $mysql::params::service_name:
        ensure  => $ensure,
        enable  => $ensure ? {
            'running' => true,
            'stopped' => false,
        }
    }
}
