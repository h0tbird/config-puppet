#------------------------------------------------------------------------------
# Class: samba::params
#
#   This class is part of the samba module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-10
#
#------------------------------------------------------------------------------
class samba::params {

    # Require the delegated class:
    Class["${module_name}"] -> Class["${module_name}::params"]

    # Set values unique to particular platforms:
    $files = "puppet:///modules/${module_name}/${operatingsystem}/${operatingsystemrelease}"
    $templates = "${module_name}/${operatingsystem}/${operatingsystemrelease}"

    case $operatingsystem {

        /(RedHat|CentOS|Fedora)/: {
            $packages       = [ 'samba' ]
            $service_config = '/etc/samba/smb.conf'
            $service_name   = 'smb'
        }

        default: {
            fail ( "${module_name}::params ${operatingsystem} is not supported yet." )
        }
    }
}
