#------------------------------------------------------------------------------
# Class: mysql::config
#
#   This class is part of the mysql module.
#   You should not be calling this class.
#   The delegated class is Class['mysql'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-12-29
#
#------------------------------------------------------------------------------
class mysql::config {

    # Collect variables:
    $templates = getvar("${module_name}::params::templates")
    $configs   = getvar("${module_name}::params::configs")

    # Define the target file:
    concat { $configs[0]: ensure => present }

    # Config file header:
    concat::fragment { 'mycnf_header':
        ensure  => present,
        target  => $configs[0],
        content => template("${templates}/my.cnf_header.erb"),
        order   => '00',
    }
}
