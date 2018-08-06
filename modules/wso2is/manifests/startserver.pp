class wso2is::start{

	$install_path			 = '/usr/lib/wso2/wso2is/5.6.0'

#  exec { 'start WSO2 Identity Server':
#    command  => "sh wso2server.sh start",
#    cwd      => "${install_path}/bin",
#    path     => '/usr/bin:/usr/sbin:/bin',
#    }
#file { "/etc/init.d/wso2is":
#    ensure  => file,
#    content => template("wso2is/wso2service.erb"),
#    owner   => 'ubuntu',
#    mode    => '0600',
#    notify  => Service['wso2is'],
#} ->

exec { 'systemctl daemon-reload':
    command  => "systemctl daemon-reload",
    cwd      => "${install_path}/bin",
    path     => '/usr/bin:/usr/sbin:/bin',
    }

service { 'wso2is':
    enable => true,
    ensure => running,
}

}
