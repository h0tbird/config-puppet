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

    $unix  = 'yes',
    $samba = 'no',
    $ftp   = 'no'

) {

    # Check for valid values:
    if ! ( $unix in [ 'yes', 'no' ] ) {
        fail("${module_name} 'unix' must be one of: 'yes' or 'no'")
    }

    if ! ( $samba in [ 'yes', 'no' ] ) {
        fail("${module_name} 'samba' must be one of: 'yes' or 'no'")
    }

    if ! ( $ftp in [ 'yes', 'no' ] ) {
        fail("${module_name} 'ftp' must be one of: 'yes' or 'no'")
    }

    # Includes:
    include user::virtual

    # Create the user:
    if $unix == 'yes' { realize (User["${name}"], Group["${name}"]) }
    if $samba == 'yes' { samba::user { "${name}": } }
}
