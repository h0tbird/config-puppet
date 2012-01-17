#------------------------------------------------------------------------------
# puppet apply 00_mysql.pp --graph
#------------------------------------------------------------------------------

class { 'mysql':
    ensure  => running,
    version => present,
}

mysqldb { 'puppet': 
    ensure  => present,
    charset => 'latin1',
}

mysqluser { 'marc@localhost':
    ensure        => present,
    password_hash => '00000111110000011111000001111100000111110',
}
