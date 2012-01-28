#------------------------------------------------------------------------------
# Class: puppet::service
#
#   This class is part of the puppet module.
#   You should not be calling this class.
#   The delegated class is Class['puppet'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-10-12
#
#------------------------------------------------------------------------------
class puppet::service {

    # Collect variables:
    $ensure = getvar("${module_name}::ensure")

    # Start or stop the service:
    service { $puppet::params::service_name:
        ensure  => $ensure,
        enable  => $ensure ? {
            'running' => true,
            'stopped' => false,
        }
    }
}
