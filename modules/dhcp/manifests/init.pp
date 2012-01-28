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

    # Validate parameters:
    validate_re($ensure, '^running$|^stopped$')
    validate_re($version, '^present$|^latest$')

    # Register this module:
    if defined(Class['motd']) { motd::register { $module_name: } }

    # Set the requirements:
    anchor { "${module_name}::begin":   } ->
    class  { "${module_name}::params":  } ->
    class  { "${module_name}::install": ensure => $version } ->
    class  { "${module_name}::config":  } ~>
    class  { "${module_name}::service": ensure => $ensure } ->
    anchor { "${module_name}::end":     }
}
