#------------------------------------------------------------------------------
# Class: mysql::install
#
#   This class is part of the mysql module.
#   You should not be calling this class.
#   The delegated class is Class['mysql'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-12-29
#
#------------------------------------------------------------------------------
class mysql::install ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !($ensure in ['present','latest']) { fail("${module_name}::install 'ensure' must be one of: 'present' or 'latest'") }

    # Install the package/s:
    package { $mysql::params::packages: ensure => $ensure }
}