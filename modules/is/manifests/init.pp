#----------------------------------------------------------------------------
#  Copyright (c) 2018 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#----------------------------------------------------------------------------

class is (
  $user                 = $is::params::user,
  $user_id              = $is::params::user_id,
  $user_group           = $is::params::user_group,
  $user_group_id        = $is::params::user_group_id,
  $service_name         = $is::params::service_name,
  $start_script_template = $is::params::start_script_template,
  $template_list        = $is::params::template_list,
  $jre_version          = $is::params::jre_version,

  # Master Datasources
  $wso2_carbon_db       = $is::params::wso2_carbon_db,
  $wso2_reg_db          = $is::params::wso2_reg_db,
  $wso2_user_db         = $is::params::wso2_user_db,
  $wso2_identity_db     = $is::params::wso2_identity_db,
  $wso2_consent_db      = $is::params::wso2_consent_db,

  $ports                = $is::params::ports,
  $hostname             = $is::params::hostname,
  $mgt_hostname         = $is::params::mgt_hostname
)

  inherits is::params {

  # Checking for the OS family
  if $::osfamily == 'redhat' {
    $is_package = 'wso2is-linux-installer-x64-5.6.0.rpm'
    $install_provider = 'rpm'
    $install_path = '/usr/lib64/wso2/wso2is/5.6.0'
  }
  elsif $::osfamily == 'debian' {
    $is_package = 'wso2is-linux-installer-x64-5.6.0.deb'
    $install_provider = 'dpkg'
    $install_path = '/usr/lib/wso2/wso2is/5.6.0'
  }

  # Create wso2 group
  group { $user_group:
    ensure => present,
    gid    => $user_group_id,
    system => true,
  }

  # Create wso2 user
  user { $user:
    ensure => present,
    uid    => $user_id,
    gid    => $user_group_id,
    home   => "/home/${user}",
    system => true,
  }

  # Ensure /opt/is directory is available
  file { "/opt/${service_name}":
    ensure => directory,
    owner  => $user,
    group  => $user_group,
  }

  # Copy the relevant installer to the /opt/is directory
  file { "/opt/${service_name}/${is_package}":
    owner  => $user,
    group  => $user_group,
    mode   => '0644',
    source => "puppet:///modules/${module_name}/${is_package}",
  }

  # Install WSO2 Identity Server
  package { $service_name:
    provider => $install_provider,
    ensure   => installed,
    source   => "/opt/${service_name}/${is_package}"
  }

  # Change the ownership of the installation directory to wso2 user & group
  file { $install_path:
    ensure  => directory,
    owner   => $user,
    group   => $user_group,
    require => [ User[$user], Group[$user_group]],
    recurse => true
  }

  # Copy configuration changes to the installed directory
  $template_list.each |String $template| {
    file { "${install_path}/${template}":
      ensure  => file,
      owner   => $user,
      group   => $user_group,
      mode    => '0644',
      content => template("${module_name}/carbon-home/${template}.erb")
    }
  }

  # Copy wso2server.sh to installed directory
  file { "${install_path}/${start_script_template}":
    ensure  => file,
    owner   => $user,
    group   => $user_group,
    mode    => '0754',
    content => template("${module_name}/carbon-home/${start_script_template}.erb")
  }

  # Copy the Unit file required to deploy the server as a service
  file { "/etc/systemd/system/${service_name}.service":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0754',
    content => template("${module_name}/${service_name}.service.erb"),
  }

  /*
    Following script can be used to copy file to a given location.
    This will copy some_file to install_path -> repository.
    Note: Ensure that file is available in modules -> is -> files
  */
  # file { "${install_path}/repository/some_file":
  #   owner  => $user,
  #   group  => $user_group,
  #   mode   => '0644',
  #   source => "puppet:///modules/is/some_file",
  # }
}
