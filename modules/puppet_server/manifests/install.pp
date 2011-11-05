#------------------------------------------------------------------------------
# Class: puppet_server::install
#
#   This class is part of the puppet_server module.
#   You should not be calling this class.
#   The delegated class is Class['puppet_server'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-05
#
#------------------------------------------------------------------------------
class puppet_server::install ( $ensure ) {

    # Deliberate cyclical dependency:
    require $module_name

    # Check for valid values:
    if !( $ensure in [ 'present', 'latest', 'absent' ] ) { fail("${module_name}::install 'ensure' must be one of: 'present', 'latest' or 'absent'") }

    # Install or remove the package/s:
    package { $puppet_server::params::packages: ensure => $ensure }

    # Clean SSL:
    exec { 'rmrfssl':
        user        => 'root',
        group       => 'root',
        refreshonly => true,
        subscribe   => Package[ $puppet_server::params::packages ],
        command     => '/bin/rm -rf /var/lib/puppet/ssl',
    }
}
