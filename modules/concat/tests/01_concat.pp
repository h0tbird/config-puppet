#------------------------------------------------------------------------------
# puppet apply 01_concat.pp --graph
#------------------------------------------------------------------------------

concat { '/tmp/hello.txt': }

concat::fragment { 'header':
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
