#------------------------------------------------------------------------------
# This class is required by all nodes:
#------------------------------------------------------------------------------

class base {

    # System users:
    user::real { 'marc': }
    user::real { 'debo': }

    # Motd module:
    class { 'motd': }

    # Ntp service:
    class { 'ntp': }

    # Samba service:
    class { 'samba':
        workgroup   => 'POPAPP',
        hosts_allow => '127. 192.168.1.',
    }
}

#------------------------------------------------------------------------------
# puppet.popapp.com
#------------------------------------------------------------------------------

node 'puppet.popapp.com' {

    require base
}
