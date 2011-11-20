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

    # Deliberate cyclical dependency:
    require $module_name

    # Set values unique to particular platforms:
    $files = "puppet:///modules/${module_name}/${operatingsystem}/${operatingsystemrelease}"
    $templates = "${module_name}/${operatingsystem}/${operatingsystemrelease}"

    case $operatingsystem {

        /(RedHat|CentOS|Fedora)/: {
            $packages       = ['openssh','openssh-server','openssh-clients','libssh2']
            $service_config = '/etc/ssh/sshd_config'
            $service_name   = 'sshd'
        }

        default: { fail("${module_name}::params ${operatingsystem} is not supported yet.") }
    }
}
