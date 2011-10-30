#------------------------------------------------------------------------------
# This node is inherited by all nodes:
#------------------------------------------------------------------------------

node 'base' {

    # By default modules set this to 'present':
    Package <||> { ensure => 'latest' }

    # Modules to be included in all nodes:
    include ntp
    include motd
    include repos
    include puppet
}

#------------------------------------------------------------------------------
# Puppet masters:
#------------------------------------------------------------------------------

node /^puppet(\d+)\.popapp/ inherits base {

    include r_puppet
}
