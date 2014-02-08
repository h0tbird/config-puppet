class r_lxc {

    #-------
    # Base:
    #-------

    require r_base

    #---------
    # Docker:
    #---------

    class { 'docker':
        other_args => '-b br0',
    }
}
