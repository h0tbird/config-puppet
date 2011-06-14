#------------------------------------------------------------------------------
# Define: concat
#
#   This module provides a simplified file fragments concatenation method.
#   Based on R.I. Pienaar concat module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-13
#
#   Tested platforms:
#       - CentOS 5.6
#
# Parameters:
#
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
    $owner  = 'root',
    $group  = 'root',
    $mode   = '0644'
) {

    # Set variables:
    $safe_name  = regsubst($name, '/', '_', 'G')
    $fragdir    = "/var/lib/puppet/concat/${safe_name}"

    # Files and directories:
    file {

         '/var/lib/puppet/concat':
            ensure  => directory,
            owner   => 'root',
            group   => 'root',
            mode    => '0755';

         "${fragdir}":
            ensure  => directory,
            owner   => 'root',
            group   => 'root',
            mode    => '0755';

         "${fragdir}/fragments":
            ensure  => directory,
            owner   => 'root',
            group   => 'root',
            mode    => '0755';

         "${fragdir}/fragments.concat":
            ensure  => present,
            owner   => 'root',
            group   => 'root',
            mode    => '0644';

         "${name}":
            ensure  => present,
            owner   => $owner,
            group   => $group,
            mode    => $mode,
            source  => "${fragdir}/fragments.concat";
    }

    # Concatenate on refresh only:
    exec { "concat_${name}":
        user        => 'root',
        group       => 'root',
        refreshonly => true,
        subscribe   => File[ "${fragdir}/fragments" ],
        notify      => File[ "${name}" ],
        command     => "/bin/cat ${fragdir}/fragments/* > ${fragdir}/fragments.concat"
    }
}
