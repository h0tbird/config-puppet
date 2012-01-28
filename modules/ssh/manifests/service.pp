#------------------------------------------------------------------------------
# Class: ssh::service
#
#   This class is part of the ssh module.
#   You should not be calling this class.
#   The delegated class is Class['ssh'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#------------------------------------------------------------------------------
class ssh::service {

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
