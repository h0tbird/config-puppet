#------------------------------------------------------------------------------
# Define: git::repo
#
#   This define is part of the git module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-26
#
#   Tested platforms:
#       - CentOS 6.0
#
# Parameters:
#
# Actions:
#
# Sample Usage:
#
#------------------------------------------------------------------------------
define git::repo (

    $path,
    $source,
    $ensure = 'present',
    $owner  = 'root',
    $group  = 'root',
    $mode   = '0664'

) {

    include git

    gitrepo { $name:
        ensure  => $ensure,
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        source  => $source,
        path    => $path,
    }

    concat { "${path}/.git/config":
        ensure  => $ensure,
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        require => Gitrepo[$name],
    }

    concat::fragment { "git_${name}_header":
        ensure  => $ensure,
        target  => "${path}/.git/config",
        content => template("${git::params::templates}/config_header.erb"),
        order   => '00',
    }
}

# [rw] git@github.com:h0tbird/puppet.git
# [ro] git://github.com/h0tbird/puppet.git
