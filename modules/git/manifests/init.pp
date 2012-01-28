#------------------------------------------------------------------------------
# Class: git
#------------------------------------------------------------------------------
class git ( $version = present ) {

    # Validate parameters:
    validate_re($version, '^present$|^latest$')

    # Register this module:
    if defined(Class['motd']) { motd::register { $module_name: } }

    # Set the requirements:
    anchor { "${module_name}::begin":   } ->
    class  { "${module_name}::params":  } ->
    class  { "${module_name}::install": } ->
    anchor { "${module_name}::end":     }
}
