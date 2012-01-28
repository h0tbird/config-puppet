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

    # Collect variable:
    $templates = getvar("${module_name}::params::templates")
    $configs   = getvar("${module_name}::params::configs")

    # Install the configuration files:
    file {

        $configs[0]:
            ensure  => present,
            content => template("${templates}/puppet.conf.erb");

        $configs[1]:
            ensure  => present,
            content => template("${templates}/auth.conf.erb");
    }
}
