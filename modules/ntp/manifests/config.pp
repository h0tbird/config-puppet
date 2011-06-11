#------------------------------------------------------------------------------
# Class: ntp::config
#
#   This class is part of the ntp module.
#   You should not be calling this class.
#   The delegated class is Class['ntp'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-05-15
#
#------------------------------------------------------------------------------
class ntp::config ( $ensure ) {

    # Deliberate cyclical dependency:
    require "${module_name}"

    # Check for valid values:
    if ! ( $ensure in [ 'present', 'absent' ] ) {
        fail ( "${module_name}::config 'ensure' must be one of: 'present' or 'absent'" )
    }

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
