#------------------------------------------------------------------------------
# Define: samba::share
#
#   This define is part of the samba module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-10
#
#------------------------------------------------------------------------------
define samba::share (
    $path,
    $ensure               = 'present',
    $comment              = 'Samba Share.',
    $writeable            = 'yes',
    $browseable           = 'yes',
    $directory_mode       = '0770',
    $force_directory_mode = '0770',
    $create_mode          = '0660',
    force_create_mode     = '0660',
    $force_group          = '', 
    $valid_users          = ''
) {

    # Check for valid values:
    if ! ( $ensure in [ 'present', 'absent' ] ) { 
        fail ( "${module_name}::share 'ensure' must be one of: 'present' or 'absent'" )
    }   

    concat::fragment { $name:
        ensure  => $ensure,
        target  => $samba::params::service_config,
        content => template("${samba::params::templates}/smb.conf_share.erb"),
    }   
}
