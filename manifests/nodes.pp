#------------------------------------------------------------------------------
# This class is required by all nodes:
#------------------------------------------------------------------------------

class base {

    # Motd module:
    class { 'motd': }

    # Ntp service:
    class { 'ntp': }

    # Samba service:
    class { 'samba':
        workgroup   => extlookup('samba_workgroup'),
        hosts_allow => extlookup('samba_hosts_allow'),
    }
}

#------------------------------------------------------------------------------
# puppet.popapp.com
#------------------------------------------------------------------------------

node 'puppet.popapp.com' {

    require base

    user::real { 'marc': samba => 'yes' }
    user::real { 'debo': samba => 'yes' }

    samba::share { 'tmp':
        path        => '/tmp',
        valid_users => 'marc',
    }
}
