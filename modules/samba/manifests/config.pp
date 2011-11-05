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
class samba::config ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !( $ensure in [ 'present', 'absent' ] ) { fail("${module_name}::config 'ensure' must be one of: 'present' or 'absent'") }

    # Define the target file:
    concat { $samba::params::service_config: ensure => $ensure }

    # Config file header:
    concat::fragment { 'smb_header':
        ensure  => $ensure,
        target  => $samba::params::service_config,
        content => template("${samba::params::templates}/smb.conf_header.erb"),
        order   => '00',
    }
}
