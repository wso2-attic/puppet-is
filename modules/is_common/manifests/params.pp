#----------------------------------------------------------------------------
#  Copyright (c) 2019 WSO2, Inc. http://www.wso2.org
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

class is_common::params {

  $packages = ["unzip"]
  $version = "5.11.0"

  # Set the location the product packages should reside in (eg: "local" in the /files directory, "remote" in a remote location)
  $pack_location = "local"
  # $pack_location = "remote"
  # $remote_jdk = "<URL_TO_JDK_FILE>"

  $user = 'wso2carbon'
  $user_group = 'wso2'
  $user_id = 802
  $user_group_id = 802

  # Performance tuning configurations
  $enable_performance_tuning = false
  $performance_tuning_flie_list = [
    'etc/sysctl.conf',
    'etc/security/limits.conf',
  ]

  # JDK Distributions
  $java_dir = "/opt"
  $java_symlink = "${java_dir}/java"
  $jdk_name = 'amazon-corretto-8.202.08.2-linux-x64'
  $java_home = "${java_dir}/${jdk_name}"

  $profile = $profile
  $target = "/mnt"
  $product_dir = "${target}/${profile}"
  $pack_dir = "${target}/${profile}/packs"
  $wso2_service_name = "wso2${profile}"

  # ----- Profile configs -----
  $pack = "wso2is-${version}"
  # $remote_pack = "<URL_TO_IS_PACK>"
  $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
  $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"

  # Pack Directories
  $carbon_home = "${product_dir}/${pack}"
  $product_binary = "${pack}.zip"

  # Server stop retry configs
  $try_count = 5
  $try_sleep = 5

  # user-mgt.xml
  $admin_username = 'admin'
  $admin_password = 'admin'
}
