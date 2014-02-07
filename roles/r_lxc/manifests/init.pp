class r_lxc {

    #-------
    # Base:
    #-------

    require r_base

    #---------
    # Docker:
    #---------

    class { 'docker': }
}
