#------------------------------------------------------------------------------
# Class: dhcp::service
#
#   This class is part of the dhcp module.
#   You should not be calling this class.
#   The delegated class is Class['dhcp'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2012-01-18
#
#------------------------------------------------------------------------------
class dhcp::service ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !($ensure in [ running, stopped ]) { fail("${module_name}::service 'ensure' must be one of: 'running' or 'stopped'") }

    # Start or stop the service:
    service { $dhcp::params::service_name:
        ensure  => $ensure,
        enable  => $ensure ? {
            'running' => true,
            'stopped' => false,
        }
    }
}
