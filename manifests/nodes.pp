#------------------------------------------------------------------------------
# This class is required by all nodes:
#------------------------------------------------------------------------------

class base {

    # System users:
    user::real { 'marc': }
    user::real { 'debo': }

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

    samba::user { 'marc': }
    samba::user { 'debo': }

    samba::share { 'tmp':
        path        => '/tmp',
        valid_users => 'marc',
    }
}
