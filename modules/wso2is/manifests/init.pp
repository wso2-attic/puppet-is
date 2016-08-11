#----------------------------------------------------------------------------
#  Copyright (c) 2016 WSO2, Inc. http://www.wso2.org
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

# Manages WSO2 Identity Server deployment
class wso2is inherits wso2base {
  $am_datasources        = hiera('wso2::am_datasources')
  $bps_datasources       = hiera('wso2::bps_datasources')
  $metrics_datasources   = hiera('wso2::metrics_datasources')
  $is_datasource         = hiera('wso2::is_datasource')
  $sso_service_providers = hiera('wso2::sso_service_providers', { })
  $enable_thrift_service = hiera('wso2::enable_thrift_service')

  wso2base::server { $wso2base::carbon_home :
    maintenance_mode    => $wso2base::maintenance_mode,
    pack_filename       => $wso2base::pack_filename,
    pack_dir            => $wso2base::pack_dir,
    carbon_home_symlink => $wso2base::carbon_home_symlink,
    install_mode        => $wso2base::install_mode,
    install_dir         => $wso2base::install_dir,
    pack_extracted_dir  => $wso2base::pack_extracted_dir,
    wso2_user           => $wso2base::wso2_user,
    wso2_group          => $wso2base::wso2_group,
    patches_dir         => $wso2base::patches_dir,
    service_name        => $wso2base::service_name,
    service_template    => $wso2base::service_template,
    hosts_template      => $wso2base::hosts_template,
    template_list       => $wso2base::template_list,
    directory_list      => $wso2base::directory_list,
    file_list           => $wso2base::file_list,
    system_file_list    => $wso2base::system_file_list,
    enable_secure_vault => $wso2base::enable_secure_vault,
    key_store_password  => $wso2base::key_store_password
  }
}