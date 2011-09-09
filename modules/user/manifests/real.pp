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

    $pass  = '',
    $samba = 'no',
    $ftp   = 'no'

) {

    # Check for valid values:
    if ! ( $samba in [ 'yes', 'no' ] ) { fail("${module_name} 'samba' must be one of: 'yes' or 'no'") }
    if ! ( $ftp in [ 'yes', 'no' ] ) { fail("${module_name} 'ftp' must be one of: 'yes' or 'no'") }

    # Includes:
    include user::virtual

    # Linux user is mandatory:
    realize ( User[ $name ], Group[ $name ] )
    User <| title == $name |> { password => $pass }

    # Samba user:
    if $samba == 'yes' { samba::user { "${name}": require => User[ $name ] } }
}
