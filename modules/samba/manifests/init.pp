#------------------------------------------------------------------------------
# Class: samba
#
#   This module manages the samba service.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-10
#
#   Tested platforms:
#       - CentOS 5.6
#
# Parameters:
#
#   ensure:  [ running | stopped | absent ]
#   version: [ present | latest ]
#
# Actions:
#
#   Installs, configures, manages and removes the samba service.
#
# Sample Usage:
#
#------------------------------------------------------------------------------
class samba (
    $ensure          = 'running',
    $version         = 'present',
    $workgroup       = 'MYGROUP',
    $server_string   = 'Samba Server Version %v',
    $netbios_name    = "${hostname}",
    $interfaces      = 'lo eth0',
    $hosts_allow     = '127.',
    $log_file        = '/var/log/samba/%m.log',
    $max_log_size    = '50',
    $security        = 'user',
    $passdb_backend  = 'tdbsam',
    $realm           = '',
    $password_server = '',
    $load_printers   = 'no',
    $cups_options    = ''
) {

    # Check for valid values:
    if ! ( $ensure in [ 'running', 'stopped', 'absent' ] ) {
        fail("${module_name} 'ensure' must be one of: 'running', 'stopped' or 'absent'")
    }

    if ! ( $version in [ 'present', 'latest' ] ) {
        fail("${module_name} 'version' must be one of: 'present' or 'latest'")
    }

    if ! ( $security in [ 'user', 'share' ] ) {
        fai("${module_name} 'security' must be one of: 'user' or 'share'")
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
