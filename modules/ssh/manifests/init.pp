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
#   ensure:  [ running | stopped ]
#   version: [ present | latest ]
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
#       ensure  => running,
#       version => present
#   }
#------------------------------------------------------------------------------
class ssh (

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
