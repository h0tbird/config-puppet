class base {

    # System users:
    class { 'user::marc': }
    class { 'user::debo': }

    # Ntp service:
    class { 'ntp':
        ensure  => 'running',
        version => 'latest',
    }

    # Samba service:
    class { 'samba':
        ensure      => 'running',
        version     => 'latest',
        workgroup   => 'POPAPP',
        hosts_allow => '127. 192.168.1.',
    }
}

node 'node1' {

    require base
}

node 'node2' {

    require base
}
