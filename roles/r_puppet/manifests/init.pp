class r_puppet (

    $users = undef,
    $repos = undef,

) {

    #----------------
    # Puppet master:
    #----------------

    include puppet::server

    #------------------
    # Users and repos:
    #------------------

    if $users { create_resources(user::real, $users) }
    if $repos { create_resources(git::repo, $repos, { before => Service['puppet'] }) }
}
