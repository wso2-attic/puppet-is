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

class wso2is::params {

	$hostname		     = 'localhost'
	$mgt_hostname		 = 'localhost'

	# Master-datasources
  $wso2_carbon_db		= {
      name                => 'WSO2_CARBON_DB',
	    description         => 'The datasource used for registry and user manager',
	    driver_class_name   => 'org.h2.Driver',
	    url                 => 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
	    username            => 'wso2carbon',
	    password            => 'wso2carbon',
	    jndi_config         => 'jdbc/WSO2CarbonDB',
	    max_active          => '50',
	    max_wait            => '60000',
	    test_on_borrow      => true,
	    default_auto_commit => false,
	    validation_query    => 'SELECT 1',
	    validation_interval => '30000'
	}

  $wso2_reg_db          = {
      name                => 'WSO2_REG_DB',
      description         => 'The datasource used for registry',
      driver_class_name   => 'org.h2.Driver',
      url                 => 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
      username            => 'wso2carbon',
      password            => 'wso2carbon',
      jndi_config         => 'jdbc/WSO2RegDS',
      max_active          => '50',
      max_wait            => '60000',
      test_on_borrow      => true,
      default_auto_commit => false,
      validation_query    => 'SELECT 1',
      validation_interval => '30000'
  }
  $wso2_user_db          = {
      name                => 'WSO2_USER_DB',
      description         => 'The datasource used for user management',
      driver_class_name   => 'org.h2.Driver',
      url                 => 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
      username            => 'wso2carbon',
      password            => 'wso2carbon',
      jndi_config         => 'jdbc/WSO2UserDS',
      max_active          => '50',
      max_wait            => '60000',
      test_on_borrow      => true,
      default_auto_commit => false,
      validation_query    => 'SELECT 1',
      validation_interval => '30000'
  }
  $wso2_identity_db          = {
      name                => 'WSO2_IDENTITY_DB',
      description         => 'The datasource used for identity management',
      driver_class_name   => 'org.h2.Driver',
      url                 => 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
      username            => 'wso2carbon',
      password            => 'wso2carbon',
      jndi_config         => 'jdbc/WSO2IdentityDS',
      max_active          => '50',
      max_wait            => '60000',
      test_on_borrow      => true,
      default_auto_commit => false,
      validation_query    => 'SELECT 1',
      validation_interval => '30000'
  }

  $wso2_consent_db          = {
      name                => 'WSO2_CONSENT_DB',
      description         => 'The datasource used for registry and user manager',
      driver_class_name   => 'org.h2.Driver',
      url                 => 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
      username            => 'wso2carbon',
      password            => 'wso2carbon',
      jndi_config         => 'jdbc/WSO2ConsentDS',
      max_active          => '50',
      max_wait            => '60000',
      test_on_borrow      => true,
      default_auto_commit => false,
      validation_query    => 'SELECT 1',
      validation_interval => '30000'
  }

	$ports = {
      offset						  => 0
  }

}
