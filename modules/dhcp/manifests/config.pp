#------------------------------------------------------------------------------
# Class: dhcp::config
#
#   This class is part of the dhcp module.
#   You should not be calling this class.
#   The delegated class is Class['dhcp'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2012-01-18
#
#------------------------------------------------------------------------------
class dhcp::config {

    # Deliberate cyclical dependency:
    require $module_name

    # Define the target file:
    concat { $dhcp::params::service_config: ensure => present }

    # Config file header:
    concat::fragment { 'dhcp_header':
        ensure  => present,
        target  => $dhcp::params::service_config,
        content => template("${dhcp::params::templates}/dhcpd.conf_header.erb"),
        order   => '00',
    }
}
