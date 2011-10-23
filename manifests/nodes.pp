#------------------------------------------------------------------------------
# This class is required by all nodes:
#------------------------------------------------------------------------------

class base {

    include motd   # Motd module.
    include ntp    # NTP module.
    include puppet # Puppet module.
}

#------------------------------------------------------------------------------
# Puppet masters:
#------------------------------------------------------------------------------

node /^puppet(\d+)\./ {

    require base

    class { 'r_puppetmaster':

        # Git clone:
        git_source => extlookup('puppet_git_repo'),
        git_path   => extlookup('puppet_confdir'),

        # Samba service:
        samba_workgroup   => extlookup('samba_workgroup'),
        samba_hosts_allow => extlookup('samba_hosts_allow'),
        samba_valid_users => [ 'marc', 'debo' ],
    }
}
