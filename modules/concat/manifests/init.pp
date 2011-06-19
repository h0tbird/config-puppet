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
#
# Parameters:
#
#   ensure: [ present | absent ]
#   owner: User who will own the file.
#   group: Group which will own the file.
#   mode: The mode of the final file.
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

         "${fragdir}":
            ensure    => $ensure ? {
            'present' => 'directory',
            'absent'  => 'absent' },
            force     => true,
            owner     => 'root',
            group     => 'root',
            mode      => '0755';

         "${name}":
            ensure    => $ensure,
            owner     => $owner,
            group     => $group,
            mode      => $mode,
    }

    # Create the basedir:
    exec { "base_${name}":
        user    => 'root',
        group   => 'root',
        before  => File[ "${fragdir}" ],
        command => '/bin/mkdir /var/lib/puppet/concat',
        creates => '/var/lib/puppet/concat',
    }

    # Concatenate on refresh only:
    exec { "concat_${name}":
        user        => 'root',
        group       => 'root',
        refreshonly => true,
        path        => [ '/bin', '/usr/bin' ],
        command     => "cat ${fragdir}/* > ${name}",
        unless      => "test -z \"$(ls -A ${fragdir})\" && cat /dev/null > ${name}",
    }
}
