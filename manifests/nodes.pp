#------------------------------------------------------------------------------
# This class is required by all nodes:
#------------------------------------------------------------------------------

class base {

    include motd  # Motd module.
    include ntp   # NTP module.
}

#------------------------------------------------------------------------------
# puppet.popapp.com
#------------------------------------------------------------------------------

node 'puppet.popapp.com' {

    include base

    class { 'r_puppetmaster':

        # Samba service:
        samba_workgroup   => extlookup('samba_workgroup'),
        samba_hosts_allow => extlookup('samba_hosts_allow'),
        samba_share_path  => extlookup('puppet_confdir'),
        samba_valid_users => [ 'marc', 'debo' ],
    }
}
