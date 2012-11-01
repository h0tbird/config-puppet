class r_base {

    # Stage: pre
    class { 'hosts': stage => pre } ->
    class { 'yum':   stage => pre }

    # Stage: main
    include ['motd','ntp','ssh','puppet::client']
}
