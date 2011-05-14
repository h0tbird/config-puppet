#------------------------------------------------------------------------------
# ntp
#------------------------------------------------------------------------------

class ntp ( $ensure = 'running' ) {

    # Check for valid values:
    if ! ( $ensure in [ 'running', 'stopped', 'absent' ] ) {
        fail("${module_name} 'ensure' must be one of: 'running', 'stopped' or 'absent'")
    }

    # Set the appropriate requirements:
    case $ensure {

        'running', 'stopped': {
            class { 'ntp::params' : } ->
            class { 'ntp::install': ensure => 'present' } ->
            class { 'ntp::config': ensure => 'present' } ~>
            class { 'ntp::service': ensure => $ensure }
        }

        'absent': {
            class { 'ntp::params' : } ->
            class { 'ntp::service': ensure => 'stopped' } ->
            class { 'ntp::config': ensure => 'absent' } ->
            class { 'ntp::install': ensure => 'absent' }
        }
    }
}
