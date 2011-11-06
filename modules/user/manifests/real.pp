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

    $pass   = extlookup("linux_pass_${name}"),
    $shell  = undef,
    $home   = undef,
    $groups = undef,
    $samba  = undef

) {

    # Includes:
    include user::virtual

    # Linux user is mandatory:
    if $shell {
        User <| title == $name |> { password => mkpasswd( $pass, $name ) }
        User <| title == $name |> { shell => '/bin/bash' }
    }

    if $home {
        exec { "${name}-home":
            refreshonly => true,
            subscribe   => User[$name],
            path        => '/bin',
            command     => "cp -r /etc/skel /home/${name} && chown -R ${name}:${name} /home/${name}",
            creates     => "/home/${name}",
        }
    }

    if $groups { User <| title == $name |> { groups +> $groups } }
    realize ( User[ $name ], Group[ $name ] )

    # Samba user:
    if $samba { samba::user { $name: pass => $pass } }
}
