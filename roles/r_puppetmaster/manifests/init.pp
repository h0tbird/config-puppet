#------------------------------------------------------------------------------
# Class: r_puppetmaster
#------------------------------------------------------------------------------
class r_puppetmaster (

    # Git clone:
    $git_source,
    $git_path,

    # Samba parameters:
    $samba_workgroup,
    $samba_hosts_allow,
    $samba_valid_users

) {

    # Dependency relationship:
    Gitrepo['puppet'] -> File["${git_path}"] -> Samba::Share['puppet']

    # Git clone:
    gitrepo { 'puppet':
        ensure => 'present',
        source => $git_source,
        path   => $git_path,
    }

    # Recursive mode and ownership:
    file { $git_path:
        owner   => 'root',
        group   => 'puppet',
        mode    => '0664',
        recurse => 'true',
        ignore  => [ '.git', '.*.swp'],
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
