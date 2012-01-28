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
class ntp::config {

    # Collect variables:
    $templates = getvar("${module_name}::params::templates")
    $configs   = getvar("${module_name}::params::configs")

    # Install the configuration files:
    file {

        $configs[0]:
            ensure  => present,
            content => template("${templates}/ntp.conf.erb"),
            owner   => 'root',
            group   => 'root',
            mode    => '0644';

        $configs[1]:
            ensure  => present,
            content => template("${templates}/step-tickers.erb"),
            owner   => 'root',
            group   => 'root',
            mode    => '0644';

        $configs[2]:
            ensure  => present,
            content => template("${templates}/keys.erb"),
            owner   => 'root',
            group   => 'root',
            mode    => '0600';
    }
}
