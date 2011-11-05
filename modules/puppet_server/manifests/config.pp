#------------------------------------------------------------------------------
# Class: puppet_server::config
#
#   This class is part of the puppet_server module.
#   You should not be calling this class.
#   The delegated class is Class['puppet_server'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-05
#
#------------------------------------------------------------------------------
class puppet_server::config ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !( $ensure in [ 'present', 'absent' ] ) { fail("${module_name}::config 'ensure' must be one of: 'present' or 'absent'") }

    # Install or remove the configuration files:
    file { $puppet_server::params::service_config:
        ensure  => $ensure,
        content => template("${puppet_server::params::templates}/fileserver.conf.erb"),
    }
}
