class r_base (

    $hosts  = undef,
    $yum    = undef,
    $ntp    = undef,
    $ssh    = undef,
    $puppet = undef,

){

    #------------
    # Stage: pre
    #------------

    class { 'hosts':
        hosts => $hosts['hosts'],
        stage => pre,
    } ->

    class { 'yum':
        version           => $yum['version'],
        cachedir          => $yum['cachedir'],
        keepcache         => $yum['keepcache'],
        debuglevel        => $yum['debuglevel'],
        logfile           => $yum['logfile'],
        exactarch         => $yum['exactarch'],
        obsoletes         => $yum['obsoletes'],
        gpgcheck          => $yum['gpgcheck'],
        plugins           => $yum['plugins'],
        installonly_limit => $yum['installonly_limit'],
        bugtracker_url    => $yum['bugtracker_url'],
        distroverpkg      => $yum['distroverpkg'],
        repos             => $yum['repos'],
        stage             => pre,
    }

    #-------------
    # Stage: main
    #-------------

    include motd

    class { 'ntp':
        ensure  => $ntp['ensure'],
        version => $ntp['version'],
        servers => $ntp['servers'],
        tickers => $ntp['tickers'],
    } ->

    class { 'ssh':
        ensure    => $ssh['ensure'],
        version   => $ssh['version'],
        root_keys => $ssh['root_keys'],
    } ->

    class { 'puppet::client':
        ensure  => $puppet['ensure'],
        version => $puppet['version'],
    }
}
