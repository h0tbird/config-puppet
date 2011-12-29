#------------------------------------------------------------------------------
# Class: mysql::params
#
#   This class is part of the mysql module.
#   You should not be calling this class.
#   The delegated class is Class['mysql'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-12-29
#
#------------------------------------------------------------------------------
class mysql::params {

    # Deliberate cyclical dependency:
    require $module_name

    # Set values unique to particular platforms:
    $files = "puppet:///modules/${module_name}/${operatingsystem}"
    $templates = "${module_name}/${operatingsystem}"

    case $operatingsystem {

        /(RedHat|CentOS|Fedora)/: {
            $packages       = 'mysql-server'
            $service_config = '/etc/my.cnf'
            $service_name   = 'mysqld'
        }

        default: { fail("${module_name}::params ${operatingsystem} is not supported yet.") }
    }
}