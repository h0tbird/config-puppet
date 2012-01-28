#------------------------------------------------------------------------------
# Class: ssh::params
#
#   This class is part of the ssh module.
#   You should not be calling this class.
#   The delegated class is Class['ssh'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#------------------------------------------------------------------------------
class ssh::params {

    # Set location for files and templates:
    $files     = "puppet:///modules/${module_name}/${operatingsystem}"
    $templates = "${module_name}/${operatingsystem}"

    # Set OS specifics:
    case $osfamily {

        'RedHat': {
            $packages = ['openssh','openssh-server','openssh-clients','libssh2']
            $configs  = ['/etc/ssh/sshd_config']
            $services = ['sshd']
        }

        default: { fail("${module_name}::params ${osfamily} family is not supported yet.") }
    }
}
