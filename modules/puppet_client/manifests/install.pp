#------------------------------------------------------------------------------
# Class: puppet_client::install
#
#   This class is part of the puppet_client module.
#   You should not be calling this class.
#   The delegated class is Class['puppet_client'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-10-12
#
#------------------------------------------------------------------------------
class puppet_client::install ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !( $ensure in [ 'present', 'latest', 'absent' ] ) { fail("${module_name}::install 'ensure' must be one of: 'present', 'latest' or 'absent'") }

    # Install or remove the package/s:
    package { $puppet_client::params::packages: ensure => $ensure }
}
