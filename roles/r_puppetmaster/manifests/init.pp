#------------------------------------------------------------------------------
# Class: r_puppetmaster
#------------------------------------------------------------------------------
class r_puppetmaster (

    # Samba parameters:
    $samba_workgroup   = undef,
    $samba_hosts_allow = undef,
    $samba_share_path  = undef,
    $samba_valid_users = undef

) {

    # Samba service:
    class { 'samba':
        workgroup   => $samba_workgroup,
        hosts_allow => $samba_hosts_allow,
    }

    # Samba share:
    samba::share { 'puppet':
        path        => $samba_share_path,
        valid_users => $samba_valid_users,
    }

    # Recursive mode and ownership:
    file { $samba_share_path:
        owner   => 'root',
        group   => 'puppet',
        mode    => '0664',
        recurse => 'true',
        ignore  => '.git',
    }

    # Users:
    user::real { $samba_valid_users:
        groups => 'puppet',
        samba  => 'yes'
    }
}
