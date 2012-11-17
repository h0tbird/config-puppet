class r_samba (

    $ensure          = undef,
    $version         = undef,
    $workgroup       = undef,
    $server_string   = undef,
    $netbios_name    = undef,
    $interfaces      = undef,
    $hosts_allow     = undef,
    $log_file        = undef,
    $max_log_size    = undef,
    $security        = undef,
    $passdb_backend  = undef,
    $realm           = undef,
    $password_server = undef,
    $load_printers   = undef,
    $cups_options    = undef,
    $shares          = undef,

){

    class { 'samba':
        ensure          => $ensure,
        version         => $version,
        workgroup       => $workgroup,
        server_string   => $server_string,
        netbios_name    => $netbios_name,
        interfaces      => $interfaces,
        hosts_allow     => $hosts_allow,
        log_file        => $log_file,
        max_log_size    => $max_log_size,
        security        => $security,
        passdb_backend  => $passdb_backend,
        realm           => $realm,
        password_server => $password_server,
        load_printers   => $load_printers,
        cups_options    => $cups_options,
        shares          => $shares,
    }
}
