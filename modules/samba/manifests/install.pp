#------------------------------------------------------------------------------
# Class: samba::install
#
#   This class is part of the samba module.
#   You should not be calling this class.
#   The delegated class is Class['samba'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-10
#
#------------------------------------------------------------------------------
class samba::install ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !( $ensure in [ 'present', 'latest', 'absent' ] ) { fail("${module_name}::install 'ensure' must be one of: 'present', 'latest' or 'absent'") }

    # Install or remove the package/s:
    package { $samba::params::packages: ensure => $ensure }
}
