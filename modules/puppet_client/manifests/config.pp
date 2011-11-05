#------------------------------------------------------------------------------
# Class: puppet_client::config
#
#   This class is part of the puppet_client module.
#   You should not be calling this class.
#   The delegated class is Class['puppet_client'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-10-12
#
#------------------------------------------------------------------------------
class puppet_client::config ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !( $ensure in [ 'present', 'absent' ] ) { fail("${module_name}::config 'ensure' must be one of: 'present' or 'absent'") }

    # Install or remove the configuration files:
    file { $puppet_client::params::service_config:
        ensure  => $ensure,
        content => template("${puppet_client::params::templates}/puppet.conf.erb"),
    }
}
