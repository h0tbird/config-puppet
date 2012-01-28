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
