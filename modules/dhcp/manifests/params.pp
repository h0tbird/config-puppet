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

    # Deliberate cyclical dependency:
    require $module_name

    # Set values unique to particular platforms:
    $files = "puppet:///modules/${module_name}/${operatingsystem}"
    $templates = "${module_name}/${operatingsystem}"

    case $operatingsystem {

        /(RedHat|CentOS|Fedora)/: {
            $packages       = ['dhcp','dhcp-common']
            $service_config = '/etc/dhcp/dhcpd.conf'
            $service_name   = 'dhcpd'
        }

        default: { fail("${module_name}::params ${operatingsystem} is not supported yet.") }
    }
}
