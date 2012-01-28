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

    # Set location for files and templates:
    $files     = "puppet:///modules/${module_name}/${operatingsystem}"
    $templates = "${module_name}/${operatingsystem}"

    # Set OS specifics:
    case $osfamily {

        'RedHat': {
            $packages = ['samba']
            $configs  = ['/etc/samba/smb.conf']
            $services = ['smb']
        }

        default: { fail("${module_name}::params ${osfamily} family is not supported yet.") }
    }
}
