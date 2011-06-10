#------------------------------------------------------------------------------
# Class: ntp::params
#
#   This class is part of the ntp module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-05-15
#
#------------------------------------------------------------------------------
class ntp::params {

    # Require the delegated class:
    Class["${module_name}"] -> Class["${module_name}::params"]

    # Set values unique to particular platforms:
    $files = "puppet:///modules/${module_name}/${operatingsystem}/${operatingsystemrelease}"
    $templates = "${module_name}/${operatingsystem}/${operatingsystemrelease}"

    case $operatingsystem {

        /(RedHat|CentOS|Fedora)/: {
            $package_name   = 'ntp'
            $service_config = '/etc/ntp.conf'
            $step_tickers   = '/etc/ntp/step-tickers'
            $keys           = '/etc/ntp/keys'
            $service_name   = 'ntpd'
        }

        default: {
            fail ( "${module_name}::params ${operatingsystem} is not supported yet." )
        }
    }
}
