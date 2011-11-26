#------------------------------------------------------------------------------
# Class: git::params
#
#   This class is part of the git module.
#   You should not be calling this class.
#   The delegated class is Class['git'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-26
#
#------------------------------------------------------------------------------
class git::params {

    # Deliberate cyclical dependency:
    require $module_name

    # Set values unique to particular platforms:
    $files = "puppet:///modules/${module_name}/${operatingsystem}/${operatingsystemrelease}"
    $templates = "${module_name}/${operatingsystem}/${operatingsystemrelease}"

    case $operatingsystem {

        /(RedHat|CentOS|Fedora)/: {
            $packages = 'git'
        }

        default: { fail("${module_name}::params ${operatingsystem} is not supported yet.") }
    }
}
