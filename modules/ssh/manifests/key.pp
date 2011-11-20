#------------------------------------------------------------------------------
# Define: ssh::key
#------------------------------------------------------------------------------
define ssh::key ($users = undef) {

    $usrs = regsubst(split(inline_template("<%= name + ',' + users %>"),','), '(^.*)', "${name}/\1")
    ssh::key::x { $usrs: key_name => $name }
}

define ssh::key::x ($key_name) {

    $user = split($name, '/')

    ssh_authorized_key { $name:
        ensure  => present,
        key     => extlookup("${module_name}/pub_key/${key_name}"),
        type    => 'ssh-rsa',
        user    => $user[1],
    }
}
