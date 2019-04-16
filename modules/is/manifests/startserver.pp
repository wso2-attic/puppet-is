class is::startserver inherits is::params {

  exec { 'daemon-reload':
    command     => "systemctl daemon-reload",
    path        => "/bin/",
  }

  service { $service_name:
    enable => true,
    ensure => running,
    subscribe => File["binary"],
  }
}
