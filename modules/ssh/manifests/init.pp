#------------------------------------------------------------------------------
# Class: ssh
#
#   This module manages the ssh service.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#   Tested platforms:
#       - CentOS 6.0
#
#   Parameters:
#
#   Actions:
#
#   Sample Usage:
#
#------------------------------------------------------------------------------
class ssh (

    $ensure  = 'running',
    $version = 'present'

) {

    # Check for valid values:
    if !( $ensure in [ 'running', 'stopped', 'absent' ] ) { fail("${module_name} 'ensure' must be one of: 'running', 'stopped' or 'absent'") }
    if !( $version in [ 'present', 'latest' ] ) { fail("${module_name} 'version' must be one of: 'present' or 'latest'") }

    # Register this module:
    motd::register { $module_name: }

    # Set the appropriate requirements:
    case $ensure {

       'running', 'stopped': {
            class { "${module_name}::params": } ->
            class { "${module_name}::install": ensure => $version  } ->
            class { "${module_name}::config":  ensure => 'present' } ~>
            class { "${module_name}::service": ensure => $ensure   }
        }

        'absent': {
            class { "${module_name}::params": } ->
            class { "${module_name}::service": ensure => 'stopped' } ->
            class { "${module_name}::config":  ensure => 'absent'  } ->
            class { "${module_name}::install": ensure => 'absent'  }
        }
    } 
}
