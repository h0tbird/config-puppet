#------------------------------------------------------------------------------
# Class: dhcp::params
#
#   This class is part of the dhcp module.
#   You should not be calling this class.
#   The delegated class is Class['dhcp'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2012-01-18
#
#------------------------------------------------------------------------------
class dhcp::params {

    # Set location for files and templates:
    $files     = "puppet:///modules/${module_name}/${operatingsystem}"
    $templates = "${module_name}/${operatingsystem}"

    # Set OS specifics:
    case $osfamily {

        'RedHat': {
            $packages = ['dhcp','dhcp-common']
            $configs  = ['/etc/dhcp/dhcpd.conf']
            $services = ['dhcpd']
        }

        default: { fail("${module_name}::params ${osfamily} family is not supported yet.") }
    }
}
