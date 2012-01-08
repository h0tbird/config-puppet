#------------------------------------------------------------------------------
# puppet apply 02_mysql.pp --graph
#------------------------------------------------------------------------------

class { 'mysql':
    ensure  => running,
    version => present,
}

mysqldb { 'puppet': 
    ensure  => absent,
    charset => 'utf8',
}
