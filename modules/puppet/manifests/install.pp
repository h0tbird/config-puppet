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
class puppet::install ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !($ensure in ['present','latest']) { fail("${module_name}::install 'ensure' must be one of: 'present' or 'latest'") }

    # Install the package/s:
    package { $puppet::params::packages: ensure => $ensure }
}
