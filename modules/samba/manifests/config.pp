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

    # Deliberate cyclical dependency:
    require $module_name

    # Define the target file:
    concat { $samba::params::service_config: ensure => present }

    # Config file header:
    concat::fragment { 'smb_header':
        ensure  => present,
        target  => $samba::params::service_config,
        content => template("${samba::params::templates}/smb.conf_header.erb"),
        order   => '00',
    }
}
