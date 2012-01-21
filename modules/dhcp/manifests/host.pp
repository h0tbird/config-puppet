#------------------------------------------------------------------------------
# Define: dhcp::host
#
#   This define is part of the dhcp module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2012-01-21
#
#   Tested platforms:
#       - CentOS 6.0
#
# Parameters:
#
#   ensure:             [ running | stopped ]
#   hardware_ethernet:  [ string ]
#   fixed_address       [ string ]
#
# Actions:
#
#   Creates a host declaration.
#
# Sample Usage:
#
#   dhcp::host { 'harpo':
#       hardware_ethernet => '08:00:27:DC:47:84',
#       fixed_address     => '192.168.1.22',
#   }
#
#------------------------------------------------------------------------------
define dhcp::host (

    $ensure            = present,
    $hardware_ethernet = undef,
    $fixed_address     = undef

) {

    # Check for valid values:
    if !($ensure in [ present, absent ]) { fail("${module_name}::share 'ensure' must be one of: 'present' or 'absent'") }

    # Create the file fragment:
    concat::fragment { $name:
        ensure  => $ensure,
        order   => '20',
        target  => $dhcp::params::service_config,
        content => template("${dhcp::params::templates}/dhcpd.conf_host.erb"),
    }
}
