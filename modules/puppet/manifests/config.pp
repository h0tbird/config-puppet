#------------------------------------------------------------------------------
# Class: puppet::config
#
#   This class is part of the puppet module.
#   You should not be calling this class.
#   The delegated class is Class['puppet'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-10-12
#
#------------------------------------------------------------------------------
class puppet::config ( $ensure ) {

    # Deliberate cyclical dependency:
    require "${module_name}"

    # Check for valid values:
    if !( $ensure in [ 'present', 'absent' ] ) { fail("${module_name}::config 'ensure' must be one of: 'present' or 'absent'") }

    # Install or remove the configuration files:
    file { $puppet::params::service_config:
        ensure  => $ensure,
        content => template("${puppet::params::templates}/puppet.conf.erb"),
    }
}
