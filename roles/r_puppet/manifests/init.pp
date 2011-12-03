#------------------------------------------------------------------------------
# Class: r_puppet
#------------------------------------------------------------------------------
class r_puppet (

    # r_puppet:
    $users = extlookup("${module_name}/users", undef, "roles/${module_name}/${fqdn}"),

    # Git:
    $git_server = extlookup("${module_name}/git/server", undef, "roles/${module_name}/${fqdn}"),
    $git_user   = extlookup("${module_name}/git/user", undef, "roles/${module_name}/${fqdn}"),
    $git_path   = extlookup("${module_name}/git/path", undef, "roles/${module_name}/${fqdn}"),

    # Samba:
    $samba_workgroup   = extlookup("${module_name}/samba/workgroup", undef, "roles/${module_name}/${fqdn}"),
    $samba_hosts_allow = extlookup("${module_name}/samba/hosts_allow", undef, "roles/${module_name}/${fqdn}")

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
    if $users {

        user::real { $users:
            other_groups   => 'puppet',
            managehome     => true,
            is_samba_user  => true,
            is_git_user    => true,
            can_login      => true,
            has_password   => false,
            has_ssh_keys   => true,
        }
    }

    # Git repo:
    if ($git_server and $git_user and $git_path) {

        git::repo { 'puppet':
            ensure  => 'present',
            owner   => 'root',
            group   => 'puppet',
            mode    => '0664',
            server  => $git_server,
            user    => $git_user,
            path    => $git_path,
        }
    }

    # Samba service:
    if ($samba_workgroup and $samba_hosts_allow) {

        class { 'samba':
            workgroup   => $samba_workgroup,
            hosts_allow => $samba_hosts_allow,
        }

        # Samba share:
        samba::share { 'puppet':
            path        => $git_path,
            comment     => 'Puppet share.',
            valid_users => $users,
            require     => Gitrepo['puppet'],
        }
    }
}
