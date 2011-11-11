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
    $create_home    = undef,
    $other_groups   = undef,
    $is_samba_user  = undef,
    $password       = extlookup("linux/pass/${name}")

) {

    # Includes:
    include user::virtual

    # Linux user is mandatory:
    if $has_password { User <| title == $name |> { password => mkpasswd($password, $name) } }
    if $can_login    { User <| title == $name |> { shell => '/bin/bash' } }
    if $other_groups { User <| title == $name |> { groups +> $other_groups } }
    realize (User[$name], Group[$name])

    if $create_home {

        exec { "${name}-home":
            refreshonly => true,
            subscribe   => User[$name],
            path        => '/bin',
            command     => "cp -r /etc/skel /home/${name} && chown -R ${name}:${name} /home/${name}",
            creates     => "/home/${name}",
        }

        if $has_ssh_keys { Ssh_authorized_key <| title == $name |> -> Exec["${name}-home"] }
    }

    # Samba user:
    if $is_samba_user { samba::user { $name: pass => $password } }
}
