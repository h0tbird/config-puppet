#------------------------------------------------------------------------------
# Class: git::install
#
#   This class is part of the git module.
#   You should not be calling this class.
#   The delegated class is Class['git'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-26
#
#------------------------------------------------------------------------------
class git::install {

    # Collect variables:
    $version  = getvar("${module_name}::version")
    $packages = getvar("${module_name}::params::packages")

    # Install the package/s:
    package { $packages: ensure => $version }
}
