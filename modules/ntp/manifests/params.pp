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

    # Set location for files and templates:
    $files     = "puppet:///modules/${module_name}/${operatingsystem}"
    $templates = "${module_name}/${operatingsystem}"

    # Set OS specifics:
    case $osfamily {

        'RedHat': {
            $packages = ['ntp']
            $configs  = ['/etc/ntp.conf','/etc/ntp/step-tickers','/etc/ntp/keys']
            $services = ['ntpd']
        }

        default: { fail("${module_name}::params ${osfamily} family is not supported yet.") }
    }
}
