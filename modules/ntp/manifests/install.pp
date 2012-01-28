#------------------------------------------------------------------------------
# Class: ntp::install
#
#   This class is part of the ntp module.
#   You should not be calling this class.
#   The delegated class is Class['ntp'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-05-15
#
#------------------------------------------------------------------------------
class ntp::install {

    # Collect variables:
    $version  = getvar("${module_name}::version")
    $packages = getvar("${module_name}::params::packages")

    # Install the package/s:
    package { $packages: ensure => $version }
}
