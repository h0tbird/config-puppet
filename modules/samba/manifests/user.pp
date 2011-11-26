#------------------------------------------------------------------------------
# Define: samba::user
#
#   This define is part of the samba module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-10
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
define samba::user ( $pass = '' ) {

    Class['samba::service'] -> Samba::User[$name]
    if defined(User[$name]) { User[$name] -> Samba::User[$name] }

    exec { "smbpasswd-${name}":
        user    => 'root',
        group   => 'root',
        path    => ['/bin','/usr/bin'],
        unless  => "printf ${pass} | iconv -f ASCII -t UTF-16LE | openssl md4 | awk '{print \"pdbedit -wL ${name} | grep -qi \"\$2}' | sh",
        command => "echo -ne \"${pass}\\n${pass}\\n\" | pdbedit -ta ${name}",
    }
}
