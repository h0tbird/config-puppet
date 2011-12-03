#------------------------------------------------------------------------------
# puppet apply 00_git.pp --graph
#------------------------------------------------------------------------------

git::repo { 'puppet':
    ensure  => 'present',
    owner   => 'root',
    group   => 'puppet',
    mode    => '0664',
    server  => 'github.com',
    user    => 'h0tbird',
    path    => '/tmp/h0tbird',
}