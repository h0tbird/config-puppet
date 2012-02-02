#------------------------------------------------------------------------------
# Class user:
#------------------------------------------------------------------------------
class user {

    # Marc
    @user { 'marc.villacorta':
        ensure     => present,
        uid        => '501',
        gid        => '501',
        comment    => extlookup("user/marc.villacorta/name"),
        password   => '!!',
        managehome => false,
        home       => extlookup("user/marc.villacorta/home"),
        shell      => '/sbin/nologin',
        require    => Group['marc.villacorta'],
    }

    @group { 'marc.villacorta':
        ensure  => present,
        gid     => '501',
    }

    # Debo
    @user { 'deborah.aguilar':
        ensure     => present,
        uid        => '502',
        gid        => '502',
        comment    => extlookup("user/deborah.aguilar/name"),
        password   => '!!',
        managehome => false,
        home       => extlookup("user/deborah.aguilar/home"),
        shell      => '/sbin/nologin',
        require    => Group['deborah.aguilar'],
    }

    @group { 'deborah.aguilar':
        ensure  => present,
        gid     => '502',
    }
}
