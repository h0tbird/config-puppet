#------------------------------------------------------------------------------
# This node is inherited by all nodes:
#------------------------------------------------------------------------------

node 'base' {

    class {
        'repos':  stage => pre;
        'hosts':  stage => pre;
        'puppet': stage => main;
        'motd':   stage => main;
        'ntp':    stage => main;
        'ssh':    stage => main;
    }
}

#------------------------------------------------------------------------------
# Puppet masters:
#------------------------------------------------------------------------------

node /^puppet(\d+)/ inherits base {

    include r_puppet
}
