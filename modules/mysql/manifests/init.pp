#------------------------------------------------------------------------------
# Class: mysql
#
#   This module manages the mysql service.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-12-29
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
#   Installs, configures and manages the mysql service.
#
# Sample Usage:
#
#   include mysql
#
#   or
#
#   class { 'mysql': }
#
#   or
#
#   class { 'mysql':
#       ensure  => running,
#       version => present
#   }
#------------------------------------------------------------------------------
class mysql (

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
    class  { "${module_name}::install": } ->
    class  { "${module_name}::config":  } ~>
    class  { "${module_name}::service": } ->
    anchor { "${module_name}::end":     }
}
