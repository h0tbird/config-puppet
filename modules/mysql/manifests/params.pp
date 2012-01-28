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

    # Set location for files and templates:
    $files     = "puppet:///modules/${module_name}/${operatingsystem}"
    $templates = "${module_name}/${operatingsystem}"

    # Set OS specifics:
    case $osfamily {

        'RedHat': {
            $packages = ['mysql','mysql-server']
            $configs  = ['/etc/my.cnf']
            $services = ['mysqld']
        }

        default: { fail("${module_name}::params ${osfamily} family is not supported yet.") }
    }
}
