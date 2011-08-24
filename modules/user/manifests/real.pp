#------------------------------------------------------------------------------
# Define: user::real
#
#    This define is part of the user module.
#
#    Marc Villacorta <marc.villacorta@gmail.com>
#    2011-08-24
#
#------------------------------------------------------------------------------

define user::real {

    include user::virtual

    realize (User["${name}"], Group["${name}"])
}
