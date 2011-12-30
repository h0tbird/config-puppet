#------------------------------------------------------------------------------
# puppet apply 00_samba.pp --graph
#------------------------------------------------------------------------------

class { 'samba':
    ensure          => running,
    version         => present,
    workgroup       => 'MYGROUP',
    server_string   => 'Samba Server Version %v',
    netbios_name    => $hostname,
    interfaces      => 'lo eth0',
    hosts_allow     => '127. 192.168.1.',
    log_file        => '/var/log/samba/%m.log',
    max_log_size    => '50',
    security        => 'user',
    passdb_backend  => 'tdbsam'
}

samba::share { 'tmp':
    path        => '/tmp',
    valid_users => 'root',
}

samba::user { 'root':
    pass => 'password',
}
