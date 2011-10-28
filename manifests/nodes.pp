#------------------------------------------------------------------------------
# This class is required by all nodes:
#------------------------------------------------------------------------------

class base {

    class { 'motd':                       }
    class { 'ntp':    version => 'latest' }
    class { 'puppet': version => 'latest' }
}

#------------------------------------------------------------------------------
# Puppet masters:
#------------------------------------------------------------------------------

node /^puppet(\d+)\./ {

    require base

    class { 'r_puppet':

        # Git clone:
        git_source => extlookup('puppet_git_repo'),
        git_path   => extlookup('puppet_confdir'),

        # Samba service:
        samba_workgroup   => extlookup('samba_workgroup'),
        samba_hosts_allow => extlookup('samba_hosts_allow'),
        samba_valid_users => [ 'marc', 'debo' ],
    }
}
