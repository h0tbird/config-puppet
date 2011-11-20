#------------------------------------------------------------------------------
# Class: ssh::config
#
#   This class is part of the ssh module.
#   You should not be calling this class.
#   The delegated class is Class['ssh'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#------------------------------------------------------------------------------
class ssh::config ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !( $ensure in [ 'present', 'absent' ] ) { fail("${module_name}::config 'ensure' must be one of: 'present' or 'absent'") }

    # Install or remove the configuration files:
    file { $ssh::params::service_config:
        ensure  => $ensure,
        content => template("${ssh::params::templates}/sshd_config.erb"),
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
    }
}
