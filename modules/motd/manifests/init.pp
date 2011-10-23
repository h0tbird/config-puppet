#------------------------------------------------------------------------------
# Class: motd
#
#   This module manages the /etc/motd file.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-14
#
#   Tested platforms:
#       - CentOS 5.6
#       - CentOS 6.0
#
# Actions:
#
#   Assemble header and footer fragments from templates.
#
# Sample Usage:
#
#   include motd
#
#   or
#
#   class { 'motd': }
#------------------------------------------------------------------------------
class motd {

    # Define the target file:
    concat { '/etc/motd': }

    # Set the file header and footer:
    concat::fragment {

        'motd_header':
            target  => '/etc/motd',
            content => template("${module_name}/motd_header.erb"),
            order   => '01';

        'motd_footer':
            target  => '/etc/motd',
            content => template("${module_name}/motd_footer.erb"),
            order   => '99'
    }
}
