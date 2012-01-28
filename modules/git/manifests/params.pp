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

    # Set location for files and templates:
    $files     = "puppet:///modules/${module_name}/${operatingsystem}"
    $templates = "${module_name}/${operatingsystem}"

    # Set OS specifics:
    case $osfamily {

        'RedHat': {
            $packages = ['git']
        }

        default: { fail("${module_name}::params ${osfamily} family is not supported yet.") }
    }
}
