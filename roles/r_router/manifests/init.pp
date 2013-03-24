class r_router ( $pppd = undef ) {

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
