class r_kvm (

    $koan    = undef,
    $libvirt = undef,
    $kvm     = undef,

) {

    #-------
    # Koan:
    #-------

    if $koan {
        package { 'koan':
            ensure => $koan['version'],
        }

        file { '/usr/lib/python2.6/site-packages/koan/virtinstall.py':
            ensure  => present,
            content => template("${module_name}/virtinstall.py.erb"),
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
        }
    }

    #------
    # KVM:
    #------

    if $kvm {
        class { 'kvm':
            version  => $kvm['version'],
            ksm      => $kvm['ksm'],
            ksmtuned => $kvm['ksmtuned'],
        }
    }

    #----------
    # Libvirt:
    #----------

    if $libvirt {
        class { 'libvirt':
            ensure                     => $libvirt['ensure'],
            version                    => $libvirt['version'],
            listen_tls                 => $libvirt['listen_tls'],
            listen_tcp                 => $libvirt['listen_tcp'],
            tls_port                   => $libvirt['tls_port'],
            tcp_port                   => $libvirt['tcp_port'],
            listen_addr                => $libvirt['listen_addr'],
            mdns_adv                   => $libvirt['mdns_adv'],
            mdns_name                  => $libvirt['mdns_name'],
            unix_sock_group            => $libvirt['unix_sock_group'],
            unix_sock_ro_perms         => $libvirt['unix_sock_ro_perms'],
            unix_sock_rw_perms         => $libvirt['unix_sock_rw_perms'],
            unix_sock_dir              => $libvirt['unix_sock_dir'],
            auth_unix_ro               => $libvirt['auth_unix_ro'],
            auth_unix_rw               => $libvirt['auth_unix_rw'],
            auth_tcp                   => $libvirt['auth_tcp'],
            auth_tls                   => $libvirt['auth_tls'],
            key_file                   => $libvirt['key_file'],
            cert_file                  => $libvirt['cert_file'],
            ca_file                    => $libvirt['ca_file'],
            crl_file                   => $libvirt['crl_file'],
            tls_no_sanity_certificate  => $libvirt['tls_no_sanity_certificate'],
            tls_no_verify_certificate  => $libvirt['tls_no_verify_certificate'],
            tls_allowed_dn_list        => $libvirt['tls_allowed_dn_list'],
            sasl_allowed_username_list => $libvirt['sasl_allowed_username_list'],
            max_clients                => $libvirt['max_clients'],
            min_workers                => $libvirt['min_workers'],
            max_workers                => $libvirt['max_workers'],
            prio_workers               => $libvirt['prio_workers'],
            max_requests               => $libvirt['max_requests'],
            max_client_requests        => $libvirt['max_client_requests'],
            log_level                  => $libvirt['log_level'],
            log_filters                => $libvirt['log_filters'],
            log_outputs                => $libvirt['log_outputs'],
            log_buffer_size            => $libvirt['log_buffer_size'],
            audit_level                => $libvirt['audit_level'],
            audit_logging              => $libvirt['audit_logging'],
            host_uuid                  => $libvirt['host_uuid'],
            keepalive_interval         => $libvirt['keepalive_interval'],
            keepalive_count            => $libvirt['keepalive_count'],
            keepalive_required         => $libvirt['keepalive_required'],
        }
    }
}
