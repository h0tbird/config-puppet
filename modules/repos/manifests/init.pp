#------------------------------------------------------------------------------
# Class repos:
#------------------------------------------------------------------------------
class repos {

    Class['repos'] { stage => 'pre' }

    yumrepo {

        'puppet':
            descr          => 'Puppetlabs Packages - $basearch',
            baseurl        => 'http://yum.puppetlabs.com/el/6/products/$basearch',
            gpgkey         => 'http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs',
            failovermethod => 'priority',
            enabled        => '1',
            gpgcheck       => '1',
            notify         => Exec['yum_clean_all'];

        'epel':
            descr          => 'Extra Packages for Enterprise Linux 6 - $basearch',
            mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
            gpgkey         => 'http://ftp.rediris.es/mirror/fedora-epel/RPM-GPG-KEY-EPEL-6',
            exclude        => 'puppet* facter',
            failovermethod => 'priority',
            enabled        => '1',
            gpgcheck       => '1',
            notify         => Exec['yum_clean_all'];

        'epel-testing':
            descr          => 'Extra Packages for Enterprise Linux 6 - Testing - $basearch',
            mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=testing-epel6&arch=$basearch',
            gpgkey         => 'http://ftp.rediris.es/mirror/fedora-epel/RPM-GPG-KEY-EPEL-6',
            exclude        => 'puppet* facter',
            failovermethod => 'priority',
            enabled        => '1',
            gpgcheck       => '1',
            notify         => Exec['yum_clean_all'];
    }

    exec { 'yum_clean_all':
        user        => 'root',
        group       => 'root',
        refreshonly => true,
        path        => '/usr/bin',
        command     => 'yum clean all',
    }
}
