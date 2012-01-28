#------------------------------------------------------------------------------
# Define: samba::share
#
#   This define is part of the samba module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-10
#
#   Tested platforms:
#       - CentOS 6.0
#
# Parameters:
#
# Actions:
#
# Sample Usage:
#
#------------------------------------------------------------------------------
define samba::share (

    $path,
    $ensure               = present,
    $comment              = 'Samba Share.',
    $writeable            = 'yes',
    $browseable           = 'yes',
    $directory_mode       = '0770',
    $force_directory_mode = '0770',
    $create_mode          = '0660',
    $force_create_mode    = '0660',
    $force_group          = undef,
    $valid_users          = undef

) {

    # Validate parameters:
    validate_re($ensure, '^present$|^absent$')
    validate_re($writeable, '^yes$|^no$')
    validate_re($browseable, '^yes$|^no$')

    # Collect variable:
    $templates = getvar("${module_name}::params::templates")
    $configs   = getvar("${module_name}::params::configs")

    # Create the file fragment:
    concat::fragment { $name:
        ensure  => $ensure,
        target  => $configs[0],
        content => template("${templates}/smb.conf_share.erb"),
    }
}
