#------------------------------------------------------------------------------
# Class: ntp::params
#
#   This class is part of the ntp module.
#   You should not be calling this class.
#   The delegated class is Class['ntp'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-05-15
#
#------------------------------------------------------------------------------
class ntp::params {

    # Deliberate cyclical dependency:
    require "${module_name}"

    # Set values unique to particular platforms:
    $files = "puppet:///modules/${module_name}/${operatingsystem}/${operatingsystemrelease}"
    $templates = "${module_name}/${operatingsystem}/${operatingsystemrelease}"

    case $operatingsystem {

        /(RedHat|CentOS|Fedora)/: {
            $packages       = [ 'ntp' ]
            $service_config = '/etc/ntp.conf'
            $step_tickers   = '/etc/ntp/step-tickers'
            $keys           = '/etc/ntp/keys'
            $service_name   = 'ntpd'
        }

        default: { fail("${module_name}::params ${operatingsystem} is not supported yet.") }
    }
}
