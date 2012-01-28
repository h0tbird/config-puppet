#------------------------------------------------------------------------------
# Class: ntp
#
#   This module manages the ntp service.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-05-15
#
#   Tested platforms:
#       - CentOS 5.6
#       - CentOS 6.0
#
# Parameters:
#
#   ensure:  [ running | stopped ]
#   version: [ present | latest ]
#   servers: [ '0.centos.pool.ntp.org iburst',
#              '1.centos.pool.ntp.org iburst',
#              '2.centos.pool.ntp.org iburst' ]
#   tickers: [ '0.centos.pool.ntp.org',
#              '1.centos.pool.ntp.org',
#              '2.centos.pool.ntp.org' ]
#
# Actions:
#
#   Installs, configures and manages the ntp service.
#
# Sample Usage:
#
#   include ntp
#
#   or
#
#   class { 'ntp': }
#
#   or
#
#   class { 'ntp':
#       ensure  => running,
#       version => present,
#       servers => [ '0.centos.pool.ntp.org iburst',
#                    '1.centos.pool.ntp.org iburst',
#                    '2.centos.pool.ntp.org iburst' ],
#       tickers => [ '0.centos.pool.ntp.org',
#                    '1.centos.pool.ntp.org',
#                    '2.centos.pool.ntp.org' ],
#   }
#------------------------------------------------------------------------------
class ntp (

    $ensure     = running,
    $version    = present,
    $servers    = [ '0.centos.pool.ntp.org iburst',
                    '1.centos.pool.ntp.org iburst',
                    '2.centos.pool.ntp.org iburst' ],
    $tickers    = [ '0.centos.pool.ntp.org',
                    '1.centos.pool.ntp.org',
                    '2.centos.pool.ntp.org' ]

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
