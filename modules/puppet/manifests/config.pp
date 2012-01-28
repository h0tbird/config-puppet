#------------------------------------------------------------------------------
# Class: puppet::config
#
#   This class is part of the puppet module.
#   You should not be calling this class.
#   The delegated class is Class['puppet'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-10-12
#
#------------------------------------------------------------------------------
class puppet::config {

    # Install the configuration files:
    file {
        
        $puppet::params::service_config:
            ensure  => present,
            content => template("${puppet::params::templates}/puppet.conf.erb");
            
        $puppet::params::auth_config:
            ensure  => present,
            content => template("${puppet::params::templates}/auth.conf.erb");
    }
}
