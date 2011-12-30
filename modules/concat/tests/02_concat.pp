#------------------------------------------------------------------------------
# puppet apply 02_concat.pp --graph
#------------------------------------------------------------------------------

concat { '/tmp/hello.txt': }

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
