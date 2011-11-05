#------------------------------------------------------------------------------
# Class: r_puppet
#------------------------------------------------------------------------------
class r_puppet (

    # Git repo:
    $git_source = extlookup('puppet_git_repo'),
    $git_path   = extlookup('puppet_confdir'),

    # Samba parameters:
    $samba_workgroup   = extlookup('samba_workgroup'),
    $samba_hosts_allow = extlookup('samba_hosts_allow'),
    $samba_valid_users = extlookup('samba_valid_users')

) {

    # Dependency relationship:
    class { 'puppet_server': } -> package { 'git': ensure => 'present' } -> Gitrepo['puppet'] -> Samba::Share['puppet']

    # Git repo:
    gitrepo { 'puppet':
        ensure  => 'present',
        owner   => 'root',
        group   => 'puppet',
        mode    => '0664',
        exclude => '*.git/*',
        source  => $git_source,
        path    => $git_path,
    }

    # Samba service:
    class { 'samba':
        workgroup   => $samba_workgroup,
        hosts_allow => $samba_hosts_allow,
    }

    # Samba share:
    samba::share { 'puppet':
        path        => $git_path,
        valid_users => $samba_valid_users,
    }

    # Users:
    user::real { $samba_valid_users:
        groups => 'puppet',
        samba  => 'yes',
    }
}
