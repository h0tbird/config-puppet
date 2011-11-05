#------------------------------------------------------------------------------
# This node is inherited by all nodes:
#------------------------------------------------------------------------------

node 'base' {

    include ntp
    include motd
    include repos
    include puppet_client
}

#------------------------------------------------------------------------------
# Puppet masters:
#------------------------------------------------------------------------------

node /^puppet(\d+)\.popapp/ inherits base {

    include r_puppet
}
