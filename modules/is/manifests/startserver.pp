class is::startserver inherits is::params {

  service { $service_name:
    enable => true,
    ensure => running,
  }
}
