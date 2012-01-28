#------------------------------------------------------------------------------
# Class: puppet::install
#
#   This class is part of the puppet module.
#   You should not be calling this class.
#   The delegated class is Class['puppet'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-10-12
#
#------------------------------------------------------------------------------
class puppet::install {

    # Collect variables:
    $version = getvar("${module_name}::version")

    # Install the package/s:
    package { $puppet::params::packages: ensure => $version }
}
