#------------------------------------------------------------------------------
# Class: ssh::install
#
#   This class is part of the ssh module.
#   You should not be calling this class.
#   The delegated class is Class['ssh'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#------------------------------------------------------------------------------
class ssh::install ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !( $ensure in [ 'present', 'latest', 'absent' ] ) { fail("${module_name}::install 'ensure' must be one of: 'present', 'latest' or 'absent'") }

    # Install or remove the package/s:
    package { $ssh::params::packages: ensure => $ensure }
}
