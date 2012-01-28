#------------------------------------------------------------------------------
# Class: ntp::service
#
#   This class is part of the ntp module.
#   You should not be calling this class.
#   The delegated class is Class['ntp'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-05-15
#
#------------------------------------------------------------------------------
class ntp::service {

    # Collect variables:
    $ensure   = getvar("${module_name}::ensure")
    $services = getvar("${module_name}::params::services")

    # Start or stop the service:
    service { $services:
        ensure  => $ensure,
        enable  => $ensure ? {
            'running' => true,
            'stopped' => false,
        }
    }
}
