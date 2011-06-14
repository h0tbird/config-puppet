#------------------------------------------------------------------------------ 
# Define: concat:fragment
#
#   This define is part of the concat module.
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
#   target:    The file that these fragments belong to.
#   content:   If present puts the content into the file.
#   source:    If content was not specified, use the source.
#   order:     By default all files gets a 10_ prefix in the directory you
#              can set it to anything else using this to influence the order
#              of the content in the file.
#   ensure:    Present/Absent or destination to a file.
#
# Actions:
#
#   Creates one fragment and ties it to the target file.
#
# Sample Usage:
#
#   concat::fragment { 'motd_header':
#       target  => '/etc/motd',
#       content => template("${module_name}/motd_header.erb"),
#       order   => '01',
#   }
#
#   or
#
#   concat::fragment { 'motd_local':
#       target  => '/etc/motd',
#       order   => 11,
#       ensure  => '/etc/motd.local',
#   }
#------------------------------------------------------------------------------
define concat::fragment(
    $target,
    $content    = '',
    $source     = '',
    $order      = '10',
    $ensure     = 'present'
) {

    # Set variables:
    $safe_target = regsubst($target, '/', '_', 'G')
    $fragdir = "/var/lib/puppet/concat/${safe_target}"

    # If content is passed, use that, else if source is passed use that.
    # If neither passed, but $ensure is in symlink form, make a symlink.
    if $content { File { content => $content } }
    elsif $source { File { source => $source } }
    elsif $ensure in [ '', 'absent', 'present', 'file', 'directory' ] {
        fail('No content, source or symlink specified.')
    }

    # Place the fragment file:
    file { "${fragdir}/fragments/${order}_${name}":
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        ensure => $ensure,
        notify => Exec[ "concat_${target}" ],
    }
}
