class r_kvm (

    $libvirt  = undef,

) {

    class { 'libvirt':
        ensure   => $libvirt['ensure'],
        version  => $libvirt['version'],
        mdns_adv => $libvirt['mdns_adv'],
    }
}
