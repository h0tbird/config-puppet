#------------------------------------------------------------------------------
# Class user::virtual
#------------------------------------------------------------------------------

class user::virtual {

    # Marc
    @user { 'marc.villacorta':
        ensure   => present,
        uid      => '501',
        gid      => '501',
        comment  => 'System user.',
        password => '!!',
        home     => '/home/marc.villacorta',
        shell    => '/sbin/nologin',
        require  => Group['marc.villacorta'],
    }

    @group { 'marc.villacorta':
        ensure  => present,
        gid     => '501',
    }

    # Debo
    @user { 'deborah.aguilar':
        ensure   => present,
        uid      => '502',
        gid      => '502',
        comment  => 'System user.',
        password => '!!',
        home     => '/home/deborah.aguilar',
        shell    => '/sbin/nologin',
        require  => Group['deborah.aguilar'],
    }

    @group { 'deborah.aguilar':
        ensure  => present,
        gid     => '502',
    }
}
