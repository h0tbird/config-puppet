#------------------------------------------------------------------------------
# Class: samba::params
#
#   This class is part of the samba module.
#   You should not be calling this class.
#   The delegated class is Class['samba'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-10
#
#------------------------------------------------------------------------------
class samba::params {

    # Deliberate cyclical dependency:
    require $module_name

    # Set values unique to particular platforms:
    $files = "puppet:///modules/${module_name}/${operatingsystem}"
    $templates = "${module_name}/${operatingsystem}"

    case $operatingsystem {

        /(RedHat|CentOS|Fedora)/: {
            $packages       = 'samba'
            $service_config = '/etc/samba/smb.conf'
            $service_name   = 'smb'
        }

        default: { fail("${module_name}::params ${operatingsystem} is not supported yet.") }
    }
}
