class base {

    class { 'ntp':
        ensure  => 'running',
        version => 'present',
    }

    class { 'user::marc': }
    class { 'user::debo': }
}

node 'node1' {

    include base
}

node 'node2' {

    include base
}
