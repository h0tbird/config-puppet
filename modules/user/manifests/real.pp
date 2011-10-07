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
    $samba  = 'no',
    $ftp    = 'no'

) {

    # Check for valid values:
    if !( $samba in [ 'yes', 'no' ] ) { fail("${module_name} 'samba' must be one of: 'yes' or 'no'") }
    if !( $ftp in [ 'yes', 'no' ] ) { fail("${module_name} 'ftp' must be one of: 'yes' or 'no'") }

    # Includes:
    include user::virtual

    # Linux user is mandatory:
    realize ( User[ $name ], Group[ $name ] )
    User <| title == $name |> { password => mkpasswd( $pass, $name ) }
    if $groups { User <| title == $name |> { groups +> $groups } }

    # Samba user:
    if $samba == 'yes' { samba::user { "${name}": pass => $pass } }
}
