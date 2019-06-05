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

class is::params inherits is_common::params {

  $start_script_template = 'bin/wso2server.sh'
  $jvmxms = '256m'
  $jvmxmx = '1024m'

  $template_list = [
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/carbon.xml',
    # 'repository/conf/cipher-standalone-config.properties',
    'repository/conf/axis2/axis2.xml',
    'repository/conf/user-mgt.xml',
    # 'repository/conf/registry.xml',
    # 'repository/conf/tomcat/catalina-server.xml',
    'repository/conf/identity/identity.xml',
    # 'repository/conf/security/authenticators.xml',
    # 'repository/conf/security/secret-conf.properties',
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

  $security_keystore_location = '${carbon.home}/repository/resources/security/wso2carbon.jks'
  $security_keystore_type = 'JKS'
  $security_keystore_password = 'wso2carbon'
  $security_keystore_key_alias = 'wso2carbon'
  $security_keystore_key_password = 'wso2carbon'

  $security_internal_keystore_location = '${carbon.home}/repository/resources/security/wso2carbon.jks'
  $security_internal_keystore_type = 'JKS'
  $security_internal_keystore_password = 'wso2carbon'
  $security_internal_keystore_key_alias = 'wso2carbon'
  $security_internal_keystore_key_password = 'wso2carbon'

  $security_trust_store_location = '${carbon.home}/repository/resources/security/client-truststore.jks'
  $security_trust_store_type = 'JKS'
  $security_trust_store_password = 'wso2carbon'

  $clustering_enabled = 'false'
  $clustering_membership_scheme = 'multicast'
}
