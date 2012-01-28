#------------------------------------------------------------------------------
# Class: samba::config
#
#   This class is part of the samba module.
#   You should not be calling this class.
#   The delegated class is Class['samba'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-10
#
#------------------------------------------------------------------------------
class samba::config {

    # Collect variable:
    $templates = getvar("${module_name}::params::templates")
    $configs   = getvar("${module_name}::params::configs")

    # Define the target file:
    concat { $configs[0]: ensure => present }

    # Config file header:
    concat::fragment { 'smb_header':
        ensure  => present,
        target  => $configs[0],
        content => template("${templates}/smb.conf_header.erb"),
        order   => '00',
    }
}
