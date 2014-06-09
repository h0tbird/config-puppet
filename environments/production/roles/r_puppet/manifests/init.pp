class r_puppet (

    $users = undef,
    $repos = undef,
    $samba = undef,

) {

    #-------
    # Base:
    #-------

    require r_base

    #----------------
    # Puppet master:
    #----------------

    include puppet::server

    #------------------
    # Users and repos:
    #------------------

    if $users { create_resources(users::user, $users) }
    if $repos { create_resources(git::repo, $repos, { before => Service['puppet'] }) }

    #--------
    # Samba:
    #--------

    if $samba {

        class { 'samba':
            ensure          => $samba['ensure'],
            version         => $samba['version'],
            workgroup       => $samba['workgroup'],
            server_string   => $samba['server_string'],
            netbios_name    => $samba['netbios_name'],
            interfaces      => $samba['interfaces'],
            hosts_allow     => $samba['hosts_allow'],
            log_file        => $samba['log_file'],
            max_log_size    => $samba['max_log_size'],
            security        => $samba['security'],
            passdb_backend  => $samba['passdb_backend'],
            realm           => $samba['realm'],
            password_server => $samba['password_server'],
            load_printers   => $samba['load_printers'],
            cups_options    => $samba['cups_options'],
            shares          => $samba['shares'],
        }
    }
}
