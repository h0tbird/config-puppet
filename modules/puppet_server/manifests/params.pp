#------------------------------------------------------------------------------
# Class: puppet_server::params
#
#   This class is part of the puppet_server module.
#   You should not be calling this class.
#   The delegated class is Class['puppet_server'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-05
#
#------------------------------------------------------------------------------
class puppet_server::params {

    # Deliberate cyclical dependency:
    require $module_name

    # Set values unique to particular platforms:
    $files = "puppet:///modules/${module_name}/${operatingsystem}/${operatingsystemrelease}"
    $templates = "${module_name}/${operatingsystem}/${operatingsystemrelease}"

    case $operatingsystem {

        /(RedHat|CentOS|Fedora)/: {
            $packages       = 'puppet-server'
            $service_config = '/etc/puppet/fileserver.conf'
            $service_name   = 'puppetmaster'
        }

        default: { fail("${module_name}::params ${operatingsystem} is not supported yet.") }
    }
}
