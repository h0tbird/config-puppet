#------------------------------------------------------------------------------
# ntp::install
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
