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

class is::params {

  $user = 'wso2carbon'
  $user_id = 802
  $user_group = 'wso2'
  $user_home = '/home/$user'
  $user_group_id = 802
  $service_name = 'wso2is'
  $hostname = 'localhost'
  $mgt_hostname = 'localhost'
  $jre_version = 'jre1.8.0_172'

  # Define the templates
  $start_script_template = 'bin/wso2server.sh'

  $template_list = [
  'repository/conf/datasources/master-datasources.xml',
    #	'repository/conf/identity/identity.xml',
    #	'repository/conf/carbon.xml',
    #	'repository/conf/user-mgt.xml',
    #	'repository/conf/axis2/axis2.xml',
  ]

  # Master-datasources.xml
  $wso2_reg_db = {
    url               => 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
    username          => 'wso2carbon',
    password          => 'wso2carbon',
    driver_class_name => 'org.h2.Driver',
  }

  $wso2_user_db = {
    url               => 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
    username          => 'wso2carbon',
    password          => 'wso2carbon',
    driver_class_name => 'org.h2.Driver',
  }

  $wso2_identity_db = {
    url               => 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
    username          => 'wso2carbon',
    password          => 'wso2carbon',
    driver_class_name => 'org.h2.Driver',
  }

  # Carbon.xml
  $ports_offset = 0

}
