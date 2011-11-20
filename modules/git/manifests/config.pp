#------------------------------------------------------------------------------
# Define: git::config
#------------------------------------------------------------------------------
define git::config (

    $system_user  = $name,
    $user_name    = undef,
    $user_email   = undef,
    $github_user  = $name,
    $github_token = undef

) {

    # notify { "Username: $user_name": }
}
