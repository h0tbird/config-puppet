#------------------------------------------------------------------------------
# puppet apply 00_git.pp --graph
#------------------------------------------------------------------------------

git::repo { 'h0tbird':
    ensure  => 'present',
    owner   => 'root',
    group   => 'puppet',
    mode    => '0664',
    source  => 'git://github.com/h0tbird/puppet.git',
    path    => '/tmp/h0tbird',
}