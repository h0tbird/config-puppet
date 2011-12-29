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
class ssh::config {

    # Deliberate cyclical dependency:
    require $module_name

    # Install the configuration files:
    file { $ssh::params::service_config:
        ensure  => present,
        content => template("${ssh::params::templates}/sshd_config.erb"),
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
    }
}
