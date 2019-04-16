class is_master::startserver inherits is_master::params {

  exec { 'daemon-reload':
    command     => "systemctl daemon-reload",
    path        => "/usr/bin/",
    refreshonly => true,
  }

  # service { $service_name:
  #   enable => true,
  #   ensure => running,
  # }
}
