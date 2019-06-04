class is::startserver inherits is::params {

  exec { 'daemon-reload':
    command => "systemctl daemon-reload",
    path    => "/bin/",
  }

  service { $profile:
    enable => true,
    ensure => running,
    subscribe => File["wso2-binary"],
  }
}
