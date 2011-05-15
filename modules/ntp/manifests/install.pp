#------------------------------------------------------------------------------
# Class: ntp::install
#
#   This class is part of the ntp module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-05-15
#
#------------------------------------------------------------------------------
class ntp::install ( $ensure ) {

    # Require the delegated class:
    Class['ntp'] -> Class['ntp::install']

    # Check for valid values:
    if ! ( $ensure in [ 'present', 'latest', 'absent' ] ) {
        fail ( "${module_name}::install 'ensure' must be one of: 'present', 'latest' or 'absent'" )
    }

    # Install or remove the package:
    package { $ntp::params::package_name: ensure => $ensure }
}
