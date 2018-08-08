class wso2is::start{

$install_path			 = '/usr/lib/wso2/wso2is/5.6.0'

exec { 'systemctl daemon-reload':
    command  => "systemctl daemon-reload",
    cwd      => "${install_path}/bin",
    path     => '/usr/bin:/usr/sbin:/bin',
    }

service { 'wso2is':
    enable 	 => true,
    ensure 	 => running,
}

}
