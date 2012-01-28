#------------------------------------------------------------------------------
# Class: puppet
#
#   This module manages the puppet service.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-10-12
#
#   Tested platforms:
#       - CentOS 6.0
#
#   Parameters:
#
#       ensure:  [ running | stopped ]
#       version: [ present | latest' ]
#
#   Actions:
#
#       Installs, configures and manages the puppet service.
#
#   Sample Usage:
#
#       include puppet
#
#       or
#
#       class { 'puppet': }
#
#       or
#
#       class { 'puppet':
#           ensure  => running,
#           version => present,
#       }
#
#------------------------------------------------------------------------------
class puppet (

    $ensure  = running,
    $version = present

) {

    # Check for valid values:
    if !($ensure in [ running, stopped ]) { fail("${module_name} 'ensure' must be one of: 'running' or 'stopped'") }
    if !($version in [ present, latest ]) { fail("${module_name} 'version' must be one of: 'present' or 'latest'") }

    # Register this module:
    if defined(Class['motd']) { motd::register { $module_name: } }

    # Set the appropriate requirements:
    class { "${module_name}::params":  } ->
    class { "${module_name}::install": } ->
    class { "${module_name}::config":  } ~>
    class { "${module_name}::service": }
}
