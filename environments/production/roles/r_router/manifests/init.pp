class r_router (

    $pppd = undef,
    $dhcp = undef,

) {

    #-------
    # Base:
    #-------

    require r_base

    #-------
    # pppd:
    #-------

    if $pppd {
        class { 'pppd':
            ensure  => $pppd['ensure'],
            version => $pppd['version'],
            ifaces  => $pppd['ifaces'],
        }
    }

    #-------
    # DHCP:
    #-------

    if $dhcp {
        class { 'dhcp':
            ensure  => $dhcp['ensure'],
            version => $dhcp['version'],
            globals => $dhcp['globals'],
            subnets => $dhcp['subnets'],
        }
    }
}
