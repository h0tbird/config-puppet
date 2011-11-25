#------------------------------------------------------------------------------
# Class: r_puppet
#------------------------------------------------------------------------------
class r_puppet (

    # r_puppet:
    $users = extlookup("${module_name}/users", undef),

    # Git:
    $git        = true,
    $git_source = extlookup("${module_name}/git/source", undef),
    $git_path   = extlookup("${module_name}/git/path", undef),

    # Samba:
    $samba             = true,
    $samba_workgroup   = extlookup("${module_name}/samba/workgroup", undef),
    $samba_hosts_allow = extlookup("${module_name}/samba/hosts_allow", undef)

) {

    # Puppet master:
    Package <| title == 'puppet' |> { name +> 'puppet-server' }
    Service <| title == 'puppet' |> { name +> 'puppetmaster' }
    Host <| title == 'localhost' |> { host_aliases +> 'puppet' }
    Host <| title == 'puppet' |> { ensure => absent }

    exec { 'rmssl':
        refreshonly => true,
        subscribe   => Package['puppet'],
        before      => Service['puppet'],
        command     => '/bin/rm -rf /var/lib/puppet/ssl',
    }

    # Users:
    user::real { $users:
        other_groups   => 'puppet',
        managehome     => true,
        is_samba_user  => $samba,
        can_login      => true,
        has_password   => false,
        has_ssh_keys   => true,
    }

    # Git repo:
    if ($git and $git != 'false') {

        include git

        git::config { $users: }

        gitrepo { 'puppet':
            ensure  => 'present',
            owner   => 'root',
            group   => 'puppet',
            mode    => '0664',
            source  => $git_source,
            path    => $git_path,
        }
    }

    # Samba service:
    if ($samba and $samba != 'false') {

        class { 'samba':
            workgroup   => $samba_workgroup,
            hosts_allow => $samba_hosts_allow,
        }

        # Samba share:
        samba::share { 'puppet':
            path        => $git_path,
            valid_users => $users,
            require     => Gitrepo['puppet'],
        }
    }
}
