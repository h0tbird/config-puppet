#------------------------------------------------------------------------------
# Class: puppet_client::params
#
#   This class is part of the puppet_client module.
#   You should not be calling this class.
#   The delegated class is Class['puppet_client'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-10-12
#
#------------------------------------------------------------------------------
class puppet_client::params {

    # Deliberate cyclical dependency:
    require $module_name

    # Set values unique to particular platforms:
    $files = "puppet:///modules/${module_name}/${operatingsystem}/${operatingsystemrelease}"
    $templates = "${module_name}/${operatingsystem}/${operatingsystemrelease}"

    case $operatingsystem {

        /(RedHat|CentOS|Fedora)/: {
            $packages       = [ 'puppet', 'facter' ]
            $service_config = '/etc/puppet/puppet.conf'
            $service_name   = 'puppet'
        }

        default: { fail("${module_name}::params ${operatingsystem} is not supported yet.") }
    }
}
