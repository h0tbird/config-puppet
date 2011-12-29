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

    # Deliberate cyclical dependency:
    require $module_name

    # Define the target file:
    concat { $mysql::params::service_config: ensure => 'present' }

    # Config file header:
    concat::fragment { 'mycnf_header':
        ensure  => 'present',
        target  => $mysql::params::service_config,
        content => template("${mysql::params::templates}/my.cnf_header.erb"),
        order   => '00',
    }
}