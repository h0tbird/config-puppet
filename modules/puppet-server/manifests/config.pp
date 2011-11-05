#------------------------------------------------------------------------------
# Class: puppet-server::config
#
#   This class is part of the puppet-server module.
#   You should not be calling this class.
#   The delegated class is Class['puppet-server'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-05
#
#------------------------------------------------------------------------------
class puppet-server::config ( $ensure ) {

    # Deliberate cyclical dependency:
    require "${module_name}"

    # Check for valid values:
    if !( $ensure in [ 'present', 'absent' ] ) { fail("${module_name}::config 'ensure' must be one of: 'present' or 'absent'") }

    # Install or remove the configuration files:
    file { $puppet-server::params::service_config:
        ensure  => $ensure,
        content => template("${puppet-server::params::templates}/fileserver.conf.erb"),
    }
}
