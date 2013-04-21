#------------------------------------------------------------------------------
# Puppet masters:
#------------------------------------------------------------------------------

node /^puppet(\d+)/ {

    include r_puppet
}

#------------------------------------------------------------------------------
# KVM hosts:
#------------------------------------------------------------------------------

node /^kvm(\d+)/ {

    include r_kvm
}

#------------------------------------------------------------------------------
# Router:
#------------------------------------------------------------------------------

node /^router(\d+)/ {

    include r_router
}

#------------------------------------------------------------------------------
# Frontends:
#------------------------------------------------------------------------------

node /^frontend(\d+)/ {

    include r_frontend
}

#------------------------------------------------------------------------------
# Backends:
#------------------------------------------------------------------------------

node /^backend(\d+)/ {

    include r_backend
}

#------------------------------------------------------------------------------
# Miners:
#------------------------------------------------------------------------------

node /^miner(\d+)/ {

    include r_miner
}
