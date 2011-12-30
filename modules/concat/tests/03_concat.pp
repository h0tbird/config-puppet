#------------------------------------------------------------------------------
# puppet apply 03_concat.pp --graph
#------------------------------------------------------------------------------

concat { '/tmp/hello.txt':
    ensure => absent
}

concat::fragment { 'header':
    ensure  => absent,
    target  => '/tmp/hello.txt',
    content => 'Hello',
    order   => '00'
}

concat::fragment { 'footer':
    ensure  => absent,
    target  => '/tmp/hello.txt',
    content => 'World',
    order   => '99'
}
