#------------------------------------------------------------------------------
# Class: samba::install
#
#   This class is part of the samba module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-10
#
#------------------------------------------------------------------------------
class samba::install ( $ensure ) {

    # Require the delegated class:
    Class["${module_name}"] -> Class["${module_name}::install"]

    # Check for valid values:
    if ! ( $ensure in [ 'present', 'latest', 'absent' ] ) {
        fail ( "${module_name}::install 'ensure' must be one of: 'present', 'latest' or 'absent'" )
    }

    # Install or remove the package/s:
    package { $samba::params::packages: ensure => $ensure }
}
