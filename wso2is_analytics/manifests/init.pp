# ------------------------------------------------------------------------------
# Copyright (c) 2017, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ------------------------------------------------------------------------------

# Manages WSO2 IS Analytics Server deployment
class wso2is_analytics (
  # wso2is_analytics specific configuration data
  $analytics_datasources  = $wso2is_analytics::params::analytics_datasources,
  $metrics_datasources    = $wso2is_analytics::params::metrics_datasources,
  $analytics_event_store_datasource = $wso2is_analytics::params::analytics_event_store_datasource,
  $analytics_processed_data_store_datasource = $wso2is_analytics::params::analytics_processed_data_store_datasource,
  $metrics_datasource     = $wso2is_analytics::params::metrics_datasource,
  $spark                  = $wso2is_analytics::params::spark,
  $ha_deployment          = $wso2is_analytics::params::ha_deployment,

  $remove_file_list       = $wso2is_analytics::params::remove_file_list,
  $packages               = $wso2is_analytics::params::packages,
  $template_list          = $wso2is_analytics::params::template_list,
  $file_list              = $wso2is_analytics::params::file_list,
  $patch_list             = $wso2is_analytics::params::patch_list,
  $cert_list              = $wso2is_analytics::params::cert_list,
  $system_file_list       = $wso2is_analytics::params::system_file_list,
  $directory_list         = $wso2is_analytics::params::directory_list,
  $hosts_mapping          = $wso2is_analytics::params::hosts_mapping,
  $java_home              = $wso2is_analytics::params::java_home,
  $java_prefs_system_root = $wso2is_analytics::params::java_prefs_system_root,
  $java_prefs_user_root   = $wso2is_analytics::params::java_prefs_user_root,
  $vm_type                = $wso2is_analytics::params::vm_type,
  $wso2_user              = $wso2is_analytics::params::wso2_user,
  $wso2_group             = $wso2is_analytics::params::wso2_group,
  $product_name           = $wso2is_analytics::params::product_name,
  $product_version        = $wso2is_analytics::params::product_version,
  $platform_version       = $wso2is_analytics::params::platform_version,
  $carbon_home_symlink    = $wso2is_analytics::params::carbon_home_symlink,
  $remote_file_url        = $wso2is_analytics::params::remote_file_url,
  $maintenance_mode       = $wso2is_analytics::params::maintenance_mode,
  $install_mode           = $wso2is_analytics::params::install_mode,
  $install_dir            = $wso2is_analytics::params::install_dir,
  $pack_dir               = $wso2is_analytics::params::pack_dir,
  $pack_filename          = $wso2is_analytics::params::pack_filename,
  $pack_extracted_dir     = $wso2is_analytics::params::pack_extracted_dir,
  $patches_dir            = $wso2is_analytics::params::patches_dir,
  $service_name           = $wso2is_analytics::params::service_name,
  $service_template       = $wso2is_analytics::params::service_template,
  $ipaddress              = $wso2is_analytics::params::ipaddress,
  $enable_secure_vault    = $wso2is_analytics::params::enable_secure_vault,
  $secure_vault_configs   = $wso2is_analytics::params::secure_vault_configs,
  $key_stores             = $wso2is_analytics::params::key_stores,
  $carbon_home            = $wso2is_analytics::params::carbon_home,
  $pack_file_abs_path     = $wso2is_analytics::params::pack_file_abs_path,

  # Templated configuration parameters
  $master_datasources     = $wso2is_analytics::params::master_datasources,
  $registry_instances     = $wso2is_analytics::params::registry_instances,
  $registry_mounts        = $wso2is_analytics::params::registry_mounts,
  $hostname               = $wso2is_analytics::params::hostname,
  $mgt_hostname           = $wso2is_analytics::params::mgt_hostname,
  $worker_node            = $wso2is_analytics::params::worker_node,
  $local_reg_datasource   = $wso2is_analytics::params::local_reg_datasource,
  $clustering             = $wso2is_analytics::params::clustering,
  $dep_sync               = $wso2is_analytics::params::dep_sync,
  $ports                  = $wso2is_analytics::params::ports,
  $jvm                    = $wso2is_analytics::params::jvm,
  $fqdn                   = $wso2is_analytics::params::fqdn,
  $sso_authentication     = $wso2is_analytics::params::sso_authentication,
  $user_management        = $wso2is_analytics::params::user_management,
) inherits wso2is_analytics::params {


  validate_hash($analytics_datasources)
  validate_hash($metrics_datasources)

  validate_string($analytics_event_store_datasource)
  validate_string($analytics_processed_data_store_datasource)
  validate_string($metrics_datasource)

  validate_hash($spark)
  validate_hash($ha_deployment)

  validate_hash($master_datasources)

  if $registry_instances != undef {
    validate_hash($registry_mounts)
  }

  if $registry_mounts != undef {
    validate_hash($registry_mounts)
  }

  validate_string($hostname)
  validate_string($mgt_hostname)
  validate_bool($worker_node)
  validate_string($local_reg_datasource)
  validate_hash($clustering)
  validate_hash($dep_sync)
  validate_hash($ports)
  validate_hash($jvm)
  validate_string($fqdn)

  if $sso_authentication != undef {
    validate_hash($sso_authentication)
  }

  validate_hash($user_management)

  class { '::wso2base':
    packages               => $packages,
    template_list          => $template_list,
    file_list              => $file_list,
    patch_list             => $patch_list,
    cert_list              => $cert_list,
    system_file_list       => $system_file_list,
    directory_list         => $directory_list,
    hosts_mapping          => $hosts_mapping,
    java_home              => $java_home,
    java_prefs_system_root => $java_prefs_system_root,
    java_prefs_user_root   => $java_prefs_user_root,
    vm_type                => $vm_type,
    wso2_user              => $wso2_user,
    wso2_group             => $wso2_group,
    product_name           => $product_name,
    product_version        => $product_version,
    platform_version       => $platform_version,
    carbon_home_symlink    => $carbon_home_symlink,
    remote_file_url        => $remote_file_url,
    maintenance_mode       => $maintenance_mode,
    install_mode           => $install_mode,
    install_dir            => $install_dir,
    pack_dir               => $pack_dir,
    pack_filename          => $pack_filename,
    pack_extracted_dir     => $pack_extracted_dir,
    patches_dir            => $patches_dir,
    service_name           => $service_name,
    service_template       => $service_template,
    ipaddress              => $ipaddress,
    enable_secure_vault    => $enable_secure_vault,
    secure_vault_configs   => $secure_vault_configs,
    key_stores             => $key_stores,
    carbon_home            => $carbon_home,
    remove_file_list       => $remove_file_list,
    pack_file_abs_path     => $pack_file_abs_path
  }

  contain wso2base
  contain wso2base::system
  contain wso2base::clean
  contain wso2base::install
  contain wso2base::configure
  contain wso2base::service

  Class['::wso2base'] -> Class['::wso2base::system']
  -> Class['::wso2base::clean'] -> Class['::wso2base::install']
  -> Class['::wso2base::configure'] ~> Class['::wso2base::service']
}
