#------------------------------------------------------------------------------
# puppet apply 01_git.pp --graph
#------------------------------------------------------------------------------

git::repo { 'h0tbird':
    ensure  => 'absent',
    owner   => 'root',
    group   => 'puppet',
    mode    => '0664',
    source  => 'git://github.com/h0tbird/puppet.git',
    path    => '/tmp/h0tbird',
}