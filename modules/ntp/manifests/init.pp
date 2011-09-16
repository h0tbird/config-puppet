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
#   ensure:  [ 'running' | 'stopped' | 'absent' ]
#   version: [ 'present' | 'latest' ]
#   servers: [ '0.centos.pool.ntp.org iburst',
#              '1.centos.pool.ntp.org iburst',
#              '2.centos.pool.ntp.org iburst' ]
#   tickers: [ '0.centos.pool.ntp.org',
#              '1.centos.pool.ntp.org',
#              '2.centos.pool.ntp.org' ]
#
# Actions:
#
#   Installs, configures, manages and removes the ntp service.
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
#       ensure  => 'running',
#       version => 'present',
#       servers => [ '0.centos.pool.ntp.org iburst',
#                    '1.centos.pool.ntp.org iburst',
#                    '2.centos.pool.ntp.org iburst' ],
#       tickers => [ '0.centos.pool.ntp.org',
#                    '1.centos.pool.ntp.org',
#                    '2.centos.pool.ntp.org' ],
#   }
#------------------------------------------------------------------------------
class ntp (
    $ensure     = 'running',
    $version    = 'present',
    $servers    = [ '0.centos.pool.ntp.org iburst',
                    '1.centos.pool.ntp.org iburst',
                    '2.centos.pool.ntp.org iburst' ],
    $tickers    = [ '0.centos.pool.ntp.org',
                    '1.centos.pool.ntp.org',
                    '2.centos.pool.ntp.org' ]
) {

    # Check for valid values:
    if ! ( $ensure in [ 'running', 'stopped', 'absent' ] ) {
        fail("${module_name} 'ensure' must be one of: 'running', 'stopped' or 'absent'")
    }

    if ! ( $version in [ 'present', 'latest' ] ) {
        fail("${module_name} 'version' must be one of: 'present' or 'latest'")
    }

    # Register this module:
    motd::register { "${module_name}": }

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
