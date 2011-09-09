#------------------------------------------------------------------------------
# This class is required by all nodes:
#------------------------------------------------------------------------------

class base {

    # Motd module:
    class { 'motd': }

    # Ntp service:
    class { 'ntp': }
}

#------------------------------------------------------------------------------
# puppet.popapp.com
#------------------------------------------------------------------------------

node 'puppet.popapp.com' {

    require base

    # Users:
    user::real { 'marc': pass => extlookup('linux_pass_marc'), samba => 'yes' }
    user::real { 'debo': pass => extlookup('linux_pass_debo'), samba => 'yes' }

    # Samba service:
    class { 'samba':
        workgroup   => extlookup('samba_workgroup'),
        hosts_allow => extlookup('samba_hosts_allow'),
    }

    # Samba shares:
    samba::share { 'puppet':
        path        => '/etc/puppet',
        valid_users => 'marc',
    }
}
