#------------------------------------------------------------------------------
# Class: r_puppet
#------------------------------------------------------------------------------
class r_puppet (

    $users             = undef,
    $git_server        = undef,
    $git_user          = undef,
    $git_path          = undef,
    $samba_workgroup   = undef,
    $samba_hosts_allow = undef,

) {

    #--------------
    # Validations:
    #--------------

    if ($git_server and $git_user and $git_path) { $git = true } else { $git = false }
    if ($users and $git_path and $samba_workgroup and $samba_hosts_allow) { $samba = true } else { $samba = false }

    #----------------
    # Puppet master:
    #----------------

    include puppet::server

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
            recursive => true,
            server    => $git_server,
            user      => $git_user,
            path      => $git_path,
            before    => Service['puppet'],
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
