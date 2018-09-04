class is::startserver (
  $service_name = $is::params::service_name
)

  inherits is::params {

  service { $service_name:
    enable => true,
    ensure => running,
  }
}
