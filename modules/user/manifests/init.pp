#------------------------------------------------------------------------------
# Class user::virtual
#------------------------------------------------------------------------------

class user::virtual {

    # Marc
    @user { 'marc':
        ensure  => present,
        uid     => '501',
        gid     => '501',
        comment => 'System user.',
        home    => '/home/marc',
        shell   => '/bin/bash',
        require => Group['marc'],
    }

    @group { 'marc':
        ensure  => present,
        gid     => '501',
    }

    # Debo
    @user { 'debo':
        ensure  => present,
        uid     => '502',
        gid     => '502',
        comment => 'System user.',
        home    => '/home/debo',
        shell   => '/bin/bash',
        require => Group['debo'],
    }

    @group { 'debo':
        ensure  => present,
        gid     => '502',
    }
}
