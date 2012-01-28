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
#       - CentOS 6.0
#
# Parameters:
#
#   ensure:          [ running | stopped ]
#   version:         [ present | latest ]
#   workgroup:       [ string ]
#   server_string:   [ string ]
#   netbios_name:    [ string ]
#   interfaces:      [ string ]
#   hosts_allow:     [ string ]
#   log_file:        [ string ]
#   max_log_size:    [ number ]
#   security:        [ 'user' | 'domain' | 'ads' | 'server' | 'share' ]
#   passdb_backend:  [ string ]
#   realm:           [ string ]
#   password_server: [ string ]
#   load_printers:   [ string ]
#   cups_options:    [ string ]
#
# Actions:
#
#   Installs, configures and manages the samba service.
#
# Sample Usage:
#
#   include samba
#
#   or
#
#   class { 'samba': }
#
#   or
#
#   class { 'samba':
#       ensure          => running,
#       version         => present,
#       workgroup       => 'MYGROUP',
#       server_string   => 'Samba Server Version %v',
#       netbios_name    => 'MYPCNAME',
#       interfaces      => 'lo eth0',
#       hosts_allow     => '127.',
#       log_file        => '/var/log/samba/%m.log',
#       max_log_size    => '50',
#       security        => 'user',
#       passdb_backend  => 'tdbsam'
#   }
#
#------------------------------------------------------------------------------
class samba (

    $ensure          = running,
    $version         = present,
    $workgroup       = 'MYGROUP',
    $server_string   = 'Samba Server Version %v',
    $netbios_name    = $hostname,
    $interfaces      = 'lo eth0',
    $hosts_allow     = '127.',
    $log_file        = '/var/log/samba/%m.log',
    $max_log_size    = '50',
    $security        = 'user',
    $passdb_backend  = 'tdbsam',
    $realm           = undef,
    $password_server = undef,
    $load_printers   = 'no',
    $cups_options    = undef

) {

    # Validate parameters:
    validate_re($ensure, '^running$|^stopped$')
    validate_re($version, '^present$|^latest$')
    validate_re($security, '^user$|^domain$|^ads$|^server$|^share$')

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
