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
    $groups = undef,
    $shell  = undef,
    $samba  = undef,
    $ftp    = undef

) {

    # Includes:
    include user::virtual

    # Linux user is mandatory:
    if $shell {
        User <| title == $name |> { password => mkpasswd( $pass, $name ) }
        User <| title == $name |> { shell => '/bin/bash' }
    }

    if $groups { User <| title == $name |> { groups +> $groups } }
    realize ( User[ $name ], Group[ $name ] )

    # Samba user:
    if $samba { samba::user { $name: pass => $pass } }
}
