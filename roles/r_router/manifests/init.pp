class r_router ( $pppd = undef ) {

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
}
