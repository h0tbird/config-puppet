node 'basenode' {

    include ntp

    file {'/tmp/base':
        ensure  => present,
        mode    => '640',
        content => "base",
    }
}

node 'node1' inherits basenode {

    file {'/tmp/node1':
        ensure  => present,
        mode    => '640',
        content => "node1",
    }
}

node 'node2' inherits basenode {

    file {'/tmp/node2':
        ensure  => present,
        mode    => '640',
        content => "node2",
    }
}
