#------------------------------------------------------------------------------
# Define: user::real
#
#    This define is part of the user module.
#
#    Marc Villacorta <marc.villacorta@gmail.com>
#    2011-08-24
#
#------------------------------------------------------------------------------
define user::real (

    $has_password   = undef,
    $has_ssh_keys   = undef,
    $can_login      = undef,
    $managehome     = undef,
    $other_groups   = undef,
    $is_samba_user  = undef,
    $is_git_user    = undef,
    $password       = extlookup("user/${name}/pass")

) {

    # Includes:
    include user::virtual

    # Linux user:
    if $has_password { User <| title == $name |> { password => mkpasswd($password, $name) } }
    if $can_login    { User <| title == $name |> { shell => '/bin/bash' } }
    if $other_groups { User <| title == $name |> { groups +> $other_groups } }
    if $managehome   { User <| title == $name |> { managehome => $managehome } }
    if $has_ssh_keys { ssh::key { $name: users => extlookup("user/${name}/grant") } }
    realize (User[$name], Group[$name])

    # Samba user:
    if $is_samba_user { samba::user { $name: pass => $password } }

    # Git user:
    if $is_git_user { git::user { $name: } }
}
