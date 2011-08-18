#------------------------------------------------------------------------------
# Define: motd::register
#
#   This module manages the /etc/motd file.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-14
#
#   Tested platforms:
#       - CentOS 5.6
#	- CentOS 6.0
#
# Actions:
#
#   Creates a file fragment to be assembled in the target file. 
#------------------------------------------------------------------------------
define motd::register ( $order = '10' ) {

    # File fragment:
    concat::fragment { "motd_fragment_${name}":
        target  => '/etc/motd',
        content => "[1;34m${name}[0m, ",
        order   => $order,
    }
}
