#------------------------------------------------------------------------------
# Class: r_puppet
#------------------------------------------------------------------------------
class r_puppet (

    #--------
    # Users:
    #--------

    $users = extlookup("${module_name}/users", undef, "roles/${module_name}/${::fqdn}"),

    #------
    # Git:
    #------

    $git_server = extlookup("${module_name}/git/server", undef, "roles/${module_name}/${::fqdn}"),
    $git_user   = extlookup("${module_name}/git/user", undef, "roles/${module_name}/${::fqdn}"),
    $git_path   = extlookup("${module_name}/git/path", undef, "roles/${module_name}/${::fqdn}"),

    #--------
    # Samba:
    #--------

    $samba_workgroup   = extlookup("${module_name}/samba/workgroup", undef, "roles/${module_name}/${::fqdn}"),
    $samba_hosts_allow = extlookup("${module_name}/samba/hosts_allow", undef, "roles/${module_name}/${::fqdn}")

) {

    #--------------
    # Validations:
    #--------------

    if ($git_server and $git_user and $git_path) { $git = true } else { $git = false }
    if ($users and $git_path and $samba_workgroup and $samba_hosts_allow) { $samba = true } else { $samba = false }

    #----------------
    # Puppet master:
    #----------------

    Package <| title == 'puppet' |> { name +> 'puppet-server' }
    Service <| title == 'puppet' |> { name +> 'puppetmaster' }
    Host <| title == 'localhost' |> { host_aliases +> ['puppet', "puppet.${::domain}"] }
    Host <| title == 'puppet' |> { ensure => absent }

    exec { 'rm_ssl':
        refreshonly => true,
        subscribe   => Package['puppet'],
        before      => Service['puppet'],
        command     => '/bin/rm -rf /var/lib/puppet/ssl',
    }

    #---------------
    # System users:
    #---------------

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

    #-----------
    # Git repo:
    #-----------

    if $git {

        git::repo { 'puppet':
            ensure    => 'present',
            owner     => 'root',
            group     => 'puppet',
            mode      => '0664',
            submodule => true,
            server    => $git_server,
            user      => $git_user,
            path      => $git_path,
        }
    }

    #----------------
    # Samba service:
    #----------------

    if $samba {

        class { 'samba':
            workgroup   => $samba_workgroup,
            hosts_allow => $samba_hosts_allow,
        }

        samba::share { 'puppet':
            path        => $git_path,
            comment     => 'Puppet share.',
            valid_users => $users,
            require     => Gitrepo['puppet'],
        }
    }
}
