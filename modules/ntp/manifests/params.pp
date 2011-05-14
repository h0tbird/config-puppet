#------------------------------------------------------------------------------
# ntp::params
#------------------------------------------------------------------------------

class ntp::params {

    # Require the delegated class:
    Class['ntp'] -> Class['ntp::params']

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
    }
}
