#------------------------------------------------------------------------------
# Class: git::install
#
#   This class is part of the git module.
#   You should not be calling this class.
#   The delegated class is Class['git'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-26
#
#------------------------------------------------------------------------------
class git::install ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !($ensure in ['present','latest']) { fail("${module_name}::install 'ensure' must be one of: 'present' or 'latest'") }

    # Install the package/s:
    package { $git::params::packages: ensure => $ensure }
}
