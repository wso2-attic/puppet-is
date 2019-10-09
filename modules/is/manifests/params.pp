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

class is::params inherits is_common::params {

  $start_script_template = 'bin/wso2server.sh'
  $jvmxms = '256m'
  $jvmxmx = '1024m'

  $template_list = [
    'repository/conf/deployment.toml'
  ]

  # Define file list
  $file_list = [
    # 'password-tmp',
    # 'XMLInputFactory.properties',
    # 'repository/conf/jms.properties',
    # 'repository/resources/security',
    # 'repository/conf/security/cipher-text.properties',
    # 'repository/conf/security/cipher-tool.properties',
    # 'lib',
  ]

  # Define remove file list
  $file_removelist = []

  # carbon.xml configs
  $ports_offset = 0
  /*
     Host name or IP address of the machine hosting this server
     e.g. www.wso2.org, 192.168.1.10
     This is will become part of the End Point Reference of the
     services deployed on this server instance.
  */
  $hostname = 'localhost'
  $mgt_hostname = 'localhost'

  # ----- Database config params -----
  $identity_db_type = 'h2'
  $identity_db_url = 'jdbc:h2:./repository/database/WSO2IDENTITY_DB;DB_CLOSE_ON_EXIT=FALSE'
  $identity_db_username = 'wso2carbon'
  $identity_db_password = 'wso2carbon'
  $identity_db_driver = 'org.h2.Driver'
  $identity_db_validation_query = 'SELECT 1'

  $shared_db_type = 'h2'
  $shared_db_url = 'jdbc:h2:./repository/database/WSO2SHARED_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000'
  $shared_db_username = 'wso2carbon'
  $shared_db_password = 'wso2carbon'
  $shared_db_driver = 'org.h2.Driver'
  $shared_db_validation_query = 'SELECT 1'

  $bps_db_url = 'jdbc:h2:file:./repository/database/jpadb;DB_CLOSE_ON_EXIT=FALSE;MVCC=TRUE'
  $bps_db_username = 'wso2carbon'
  $bps_db_password = 'wso2carbon'
  $bps_db_driver = 'org.h2.Driver'
  $bps_db_validation_query = 'SELECT 1'

  $consent_db_url = 'dbc:h2:./repository/database/WSO2IDENTITY_DB;DB_CLOSE_ON_EXIT=FALSE'
  $consent_db_username = 'wso2carbon'
  $consent_db_password = 'wso2carbon'
  $consent_db_driver = 'org.h2.Driver'
  $consent_db_validation_query = 'SELECT 1'

  # ----- Security config params -----
  $security_keystore_location = 'wso2carbon.jks'
  $security_keystore_type = 'JKS'
  $security_keystore_password = 'wso2carbon'
  $security_keystore_key_alias = 'wso2carbon'
  $security_keystore_key_password = 'wso2carbon'

  $security_internal_keystore_location = 'wso2carbon.jks'
  $security_internal_keystore_type = 'JKS'
  $security_internal_keystore_password = 'wso2carbon'
  $security_internal_keystore_key_alias = 'wso2carbon'
  $security_internal_keystore_key_password = 'wso2carbon'

  $security_trust_store_location = 'client-truststore.jks'
  $security_trust_store_type = 'JKS'
  $security_trust_store_password = 'wso2carbon'

  $clustering_enabled = 'false'
  $clustering_membership_scheme = 'multicast'
}
