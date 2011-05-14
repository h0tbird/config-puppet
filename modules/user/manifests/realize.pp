#------------------------------------------------------------------------------
# Class user::realize
#------------------------------------------------------------------------------

class user::realize (

    $user   = 'UNSET',
    $group  = 'UNSET'

) inherits user::virtual {

    if $user != 'UNSET' {
        realize ( User["${user}"] )
    }

    if $group != 'UNSET' {
        realize ( Group["${group}"] )
    }
}
