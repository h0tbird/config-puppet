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
class ntp::install ( $ensure ) {

    # Deliberate cyclical dependency:
    require "${module_name}"

    # Check for valid values:
    if ! ( $ensure in [ 'present', 'latest', 'absent' ] ) {
        fail ( "${module_name}::install 'ensure' must be one of: 'present', 'latest' or 'absent'" )
    }

    # Install or remove the package/s:
    package { $ntp::params::packages: ensure => $ensure }
}
