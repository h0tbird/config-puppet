#------------------------------------------------------------------------------
# Class: dhcp::install
#
#   This class is part of the dhcp module.
#   You should not be calling this class.
#   The delegated class is Class['dhcp'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2012-01-18
#
#------------------------------------------------------------------------------
class dhcp::install ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !($ensure in [ present, latest ]) { fail("${module_name}::install 'ensure' must be one of: 'present' or 'latest'") }

    # Install the package/s:
    package { $dhcp::params::packages: ensure => $ensure }
}
