#------------------------------------------------------------------------------
# Class: git
#------------------------------------------------------------------------------
class git ( $version = present ) {

    # Check for valid values:
    if !($version in [ present, latest ]) { fail("${module_name} 'version' must be one of: 'present' or 'latest'") }

    # Register this module:
    if defined(Class['motd']) { motd::register { $module_name: } }

    # Set the appropriate requirements:
    class { "${module_name}::params": } ->
    class { "${module_name}::install": ensure => $version }
}
