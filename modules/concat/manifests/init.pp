#------------------------------------------------------------------------------
# Define: concat
#
#   This module provides a simplified file fragments concatenation method.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-13
#
#   Tested platforms:
#       - CentOS 5.6
#       - CentOS 6.0
#
# Parameters:
#
#   ensure: [ 'present' | 'absent' ]
#   owner:  User who will own the file.
#   group:  Group which will own the file.
#   mode:  The mode of the final file.
#
# Actions:
#
#   Assemble a target file using fragments from other files or templates.
#
# Sample Usage:
#
#   concat { '/etc/named.conf': }
#
#   or
#
#   concat { '/etc/named.conf':
#       owner  => 'root',
#       group  => 'root',
#       mode   => '0644',
#       notify => Service[ 'named' ],
#   }
#
#   or
#
#   concat { '/etc/named.conf':
#       ensure => 'absent',
#   }
#------------------------------------------------------------------------------
define concat (

    $ensure = 'present',
    $owner  = 'root',
    $group  = 'root',
    $mode   = '0644'

) {

    # Set variables:
    $safe_name  = regsubst($name, '/', '_', 'G')
    $fragdir    = "/var/lib/puppet/concat/${safe_name}"

    # Files and directories:
    file {

         $fragdir:
            ensure  => 'directory',
            owner   => 'root',
            group   => 'root',
            mode    => '0755';

         $name:
            ensure  => $ensure,
            owner   => $owner,
            group   => $group,
            mode    => $mode,
    }

    # Create the basedir:
    exec { "base_${name}":
        user    => 'root',
        group   => 'root',
        before  => File[ "$fragdir" ],
        command => '/bin/mkdir /var/lib/puppet/concat',
        creates => '/var/lib/puppet/concat',
    }

    # Concatenate on refresh only:
    exec { "concat_${name}":
        user        => 'root',
        group       => 'root',
        refreshonly => true,
        subscribe   => File[ "$name" ],
        path        => [ '/bin', '/usr/bin' ],
        command     => "cat ${fragdir}/* > ${name}",
        unless      => $ensure ? {
        'present'   => "test -z \"$(ls -A ${fragdir})\" && cat /dev/null > ${name}",
        'absent'    => "rm -f ${name} || true" },
    }
}
