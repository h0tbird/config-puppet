#------------------------------------------------------------------------------
# Class: dhcp
#
#   This module manages the dhcp service.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2012-01-18
#
#   Tested platforms:
#       - CentOS 6.0
#
# Parameters:
#
#   ensure:  [ running | stopped ]
#   version: [ present | latest ]
#
# Actions:
#
#   Installs, configures and manages the DHCP service.
#
# Sample Usage:
#
#   include dhcp
#
#   or
#
#   class { 'dhcp': }
#
#   or
#
#   class { 'dhcp':
#       ensure  => running,
#       version => present,
#   }
#
#------------------------------------------------------------------------------
class dhcp (

    $ensure  = running,
    $version = present

) {

    # Check for valid values:
    if !($ensure in [ running, stopped ]) { fail("${module_name} 'ensure' must be one of: 'running' or 'stopped'") }
    if !($version in [ present, latest ]) { fail("${module_name} 'version' must be one of: 'present' or 'latest'") }

    # Register this module:
    if defined(Class['motd']) { motd::register { $module_name: } }

    # Set the appropriate requirements:
    class { "${module_name}::params": } ->
    class { "${module_name}::install": ensure => $version } ->
    class { "${module_name}::config": } ~>
    class { "${module_name}::service": ensure => $ensure }
}
