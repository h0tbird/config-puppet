#------------------------------------------------------------------------------
# Class: ntp::config
#
#   This class is part of the ntp module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-05-15
#
#------------------------------------------------------------------------------
class ntp::config ( $ensure ) {

    # Require the delegated class:
    Class['ntp'] -> Class['ntp::config']

    # Check for valid values:
    if ! ( $ensure in [ 'present', 'absent' ] ) {
        fail ( "${module_name}::config 'ensure' must be one of: 'present' or 'absent'" )
    }

    # Get the configuration parameters:
    $servers = $ntp::servers
    $tickers = $ntp::tickers

    # Install or remove the configuration files:
    file {

        $ntp::params::service_config:
            ensure  => $ensure,
            content => template("${ntp::params::templates}/ntp.conf.erb"),
            owner   => 'root',
            group   => 'root',
            mode    => '0644';

        $ntp::params::step_tickers:
            ensure  => $ensure,
            content => template("${ntp::params::templates}/step-tickers.erb"),
            owner   => 'root',
            group   => 'root',
            mode    => '0644';

        $ntp::params::keys:
            ensure  => $ensure,
            content => template("${ntp::params::templates}/keys.erb"),
            owner   => 'root',
            group   => 'root',
            mode    => '0600';
    }
}
