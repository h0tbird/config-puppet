#------------------------------------------------------------------------------
# puppet apply 00_dhcp.pp --graph
#------------------------------------------------------------------------------

class { 'dhcp':
    ensure  => running,
    version => present,
}

dhcp::subnet { '192.168.1.0':
    netmask             => '255.255.255.0',
    domain_name         => 'popapp.lan',
    domain_name_servers => '8.8.8.8, 8.8.4.4',
    routers             => '192.168.1.1',
    subnet_mask         => '255.255.255.0',
    ntp_servers         => '192.168.1.1',
    default_lease_time  => '21600',
    max_lease_time      => '43200',
    range_dynamic_bootp => '192.168.1.200 192.168.1.250',
}

dhcp::host { 'ipad.popapp.lan':
    hardware_ethernet => 'A4:67:06:43:E4:2B',
    fixed_address     => '192.168.1.200',
}

dhcp::host { 'iphone.popapp.lan':
    hardware_ethernet => '00:26:4A:C7:31:52',
    fixed_address     => '192.168.1.201',
}
