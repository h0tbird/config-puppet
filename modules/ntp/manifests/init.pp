class ntp::install {
    package{"ntp":
        ensure => latest
    }
}

class ntp::config {
    File{
        require => Class["ntp::install"],
        notify  => Class["ntp::service"],
        owner   => "root",
        group   => "root",
        mode    => 644
    }

    file{"/etc/ntp.conf":
        source => "puppet:///ntp/ntp.conf";
 
        "/etc/ntp/step-tickers":
        source => "puppet:///ntp/step-tickers";
    }
}

class ntp::service {
    service{"ntpd":
        ensure  => running,
        enable  => true,
        require => Class["ntp::config"],
    }
}

class ntp {
    include ntp::install, ntp::config, ntp::service
}
