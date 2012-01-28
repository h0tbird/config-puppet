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
class samba::service {

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
