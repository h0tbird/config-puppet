class base {

    class { 'ntp':
        ensure  => 'running',
        version => 'present',
    }
}

node 'node1' {

    include base
}
