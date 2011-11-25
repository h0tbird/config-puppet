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
# Parameters:
#
#   ensure:  [ 'running' | 'stopped' ]
#   version: [ 'present' | 'latest' ]
#
# Actions:
#
#   Installs, configures and manages the ssh service.
#
# Sample Usage:
#
#   include ssh
#
#   or
#
#   class { 'ssh': }
#
#   or
#
#   class {
#       ensure  => 'running',
#       version => 'present'
#   }
#
#------------------------------------------------------------------------------
class ssh (

    $ensure  = 'running',
    $version = 'present'

) {

    # Check for valid values:
    if !($ensure in ['running','stopped']) { fail("${module_name} 'ensure' must be one of: 'running' or 'stopped'") }
    if !($version in ['present','latest']) { fail("${module_name} 'version' must be one of: 'present' or 'latest'") }

    # Register this module:
    if defined(Class['motd']) { motd::register { $module_name: } }

    # Set the appropriate requirements:
    class { "${module_name}::params": } ->
    class { "${module_name}::install": ensure => $version } ->
    class { "${module_name}::config": } ~>
    class { "${module_name}::service": ensure => $ensure }
}
