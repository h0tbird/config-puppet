#------------------------------------------------------------------------------
# puppet apply 01_mysql.pp --graph
#------------------------------------------------------------------------------

class { 'mysql':
    ensure  => running,
    version => present,
}

mysqldb { 'puppet': 
    ensure  => present,
    charset => 'utf8',
}
