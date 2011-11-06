#------------------------------------------------------------------------------
# Class user::virtual
#------------------------------------------------------------------------------

class user::virtual {

    # Marc
    @user { 'marc':
        ensure   => present,
        uid      => '501',
        gid      => '501',
        comment  => 'System user.',
        password => '!!',
        home     => '/home/marc',
        shell    => '/sbin/nologin',
        require  => Group['marc'],
    }

    @group { 'marc':
        ensure  => present,
        gid     => '501',
    }

    # Debo
    @user { 'debo':
        ensure   => present,
        uid      => '502',
        gid      => '502',
        comment  => 'System user.',
        password => '!!',
        home     => '/home/debo',
        shell    => '/sbin/nologin',
        require  => Group['debo'],
    }

    @group { 'debo':
        ensure  => present,
        gid     => '502',
    }
}
