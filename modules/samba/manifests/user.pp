#------------------------------------------------------------------------------
# Define: samba::user
#
#   This define is part of the samba module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-06-10
#
#------------------------------------------------------------------------------
define samba::user ( $pass = 'secret' ) {

    Class['samba'] -> Samba::User["${name}"]

    exec { "smbpasswd-${name}":
        user    => 'root',
        group   => 'root',
        path    => ['/bin','/usr/bin'],
        command => "echo -ne \"${pass}\\n${pass}\\n\" | pdbedit -ta ${name}",
    }
}
