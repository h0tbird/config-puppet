#------------------------------------------------------------------------------
# Class: samba::config
#
#   This class is part of the samba module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-10
#
#------------------------------------------------------------------------------
class samba::config ( $ensure ) {

    # Require the delegated class:
    Class["${module_name}"] -> Class["${module_name}::config"]

    # Check for valid values:
    if ! ( $ensure in [ 'present', 'absent' ] ) {
        fail ( "${module_name}::config 'ensure' must be one of: 'present' or 'absent'" )
    }

    # Get the configuration parameters:

    # Install or remove the configuration files:
    file {

        $samba::params::service_config:
            ensure  => $ensure,
            content => template("${samba::params::templates}/smb.conf.erb"),
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
    }
}
