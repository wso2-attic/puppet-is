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

class wso2is::params {

  # Set facter variables
  $vm_type                    = $::vm_type
  $ipaddress                  = $::ipaddress
  $fqdn                       = $::fqdn

  # use_hieradata facter flags whether parameter lookup should be done via Hiera
  if $::use_hieradata == 'true' {

    $user_store               = hiera('wso2::user_store', undef)
    $bps_datasources          = hiera('wso2::bps_datasources')
    $metrics_datasources      = hiera('wso2::metrics_datasources')
    $sso_service_providers    = hiera('wso2::sso_service_providers', undef)
    $identity_datasource      = hiera('wso2::identity_datasource')
    $bps_datasource           = hiera('wso2::bps_datasource')
    $metrics_datasource       = hiera('wso2::metrics_datasource')
    $enable_thrift_service    = hiera('wso2::enable_thrift_service')

    $java_prefs_system_root   = hiera('java_prefs_system_root')
    $java_prefs_user_root     = hiera('java_prefs_user_root')
    $java_home                = hiera('java_home')

    # system configuration data
    $packages                 = hiera_array('packages', undef)
    $template_list            = hiera_array('wso2::template_list')
    $file_list                = hiera_array('wso2::file_list', undef)
    $service_refresh_file_list = hiera_array('wso2::service_refresh_file_list', undef)
    $patch_list               = hiera('wso2::patch_list', undef)
    $system_file_list         = hiera_hash('wso2::system_file_list', undef)
    $directory_list           = hiera_array('wso2::directory_list', undef)
    $cert_list                = hiera_hash('wso2::cert_list', undef)
    $hosts_mapping            = hiera_hash('wso2::hosts_mapping')
    $remove_file_list         = hiera_array('wso2::remove_file_list', undef)

    $master_datasources       = hiera_hash('wso2::master_datasources')
    $registry_instances       = hiera_hash('wso2::registry_instances', undef)
    $registry_mounts          = hiera_hash('wso2::registry_mounts', undef)
    $carbon_home_symlink      = hiera('wso2::carbon_home_symlink')
    $wso2_user                = hiera('wso2::user')
    $wso2_group               = hiera('wso2::group')
    $maintenance_mode         = hiera('wso2::maintenance_mode')
    $install_mode             = hiera('wso2::install_mode')

    if $install_mode == 'file_repo' {
      $remote_file_url        = hiera('remote_file_url')
    }

    $install_dir              = hiera('wso2::install_dir')
    $pack_dir                 = hiera('wso2::pack_dir')
    $pack_filename            = hiera('wso2::pack_filename')
    $pack_extracted_dir       = hiera('wso2::pack_extracted_dir')
    $hostname                 = hiera('wso2::hostname')
    $mgt_hostname             = hiera('wso2::mgt_hostname')
    $worker_node              = hiera('wso2::worker_node')
    $patches_dir              = hiera('wso2::patches_dir')
    $service_name             = hiera('wso2::service_name')
    $service_template         = hiera('wso2::service_template')
    $usermgt_datasource       = hiera('wso2::usermgt_datasource')
    $local_reg_datasource     = hiera('wso2::local_reg_datasource')
    $clustering               = hiera('wso2::clustering')
    $dep_sync                 = hiera('wso2::dep_sync')
    $ports                    = hiera('wso2::ports')
    $jvm                      = hiera('wso2::jvm')
    # identitly.xml configurations

    $sso_authentication       = hiera('wso2::sso_authentication', undef)
    $user_management          = hiera('wso2::user_management', undef)
    $enable_secure_vault      = hiera('wso2::enable_secure_vault', undef)
    $session_persist          = hiera('wso2::session_persist', undef)
    $session_cleanUp          = hiera('wso2::session_cleanUp', undef)
    $operation_cleanUp        = hiera('wso2::operation_cleanUp', undef)
    $openID                   = hiera('wso2::openID', undef)
    $time_config              = hiera('wso2::time_config', undef)
    $oAuth                    = hiera('wso2::oAuth', undef)
    $sso                      = hiera('wso2::sso', undef)
    $passiveSTS               = hiera('wso2::passiveSTS', undef)
    $evenet_listeners         = hiera('wso2::evenet_listeners', undef)
    $cache                    = hiera('wso2::cache', undef)
    $key_stores               = hiera('wso2::key_stores')

    # catalina-server.xml configurations

    $tomcat                  = hiera('wso2::tomcat')


  } else {

    $bps_datasources       = {
      bps_ds => {
        name                    => 'BPS_DS',
        description             => 'The datasource used for bps',
        driver_class_name       => 'org.h2.Driver',
        url                     => 'jdbc:h2:file:repository/database/jpadb;DB_CLOSE_ON_EXIT=FALSE;MVCC=TRUE',
        username                => 'wso2carbon',
        password                => 'wso2carbon',
        jndi_config             => 'bpsds',
        max_active              => '50',
        max_idle                => '20',
        max_wait                => '60000',
        test_on_borrow          => true,
        use_datasource_factory  => false,
        default_auto_commit     => false,
        validation_query        => 'SELECT 1',
        validation_interval     => '30000'
      }
    }
    $metrics_datasources      = {
      wso2_metrics_db => {
        name                => 'WSO2_METRICS_DB',
        description         => 'The default datasource used for WSO2 Carbon Metrics',
        driver_class_name   => 'org.h2.Driver',
        url                 => 'jdbc:h2:repository/database/WSO2METRICS_DB;DB_CLOSE_ON_EXIT=FALSE;AUTO_SERVER=TRUE',
        username            => 'wso2carbon',
        password            => 'wso2carbon',
        jndi_config         => 'jdbc/WSO2MetricsDB',
        datasource          => 'WSO2MetricsDB',
        max_active          => '50',
        max_wait            => '60000',
        test_on_borrow      => true,
        default_auto_commit => false,
        validation_query    => 'SELECT 1',
        validation_interval => '30000'
      }
    }
    $enable_thrift_service    = false

    $java_prefs_system_root   = '/home/wso2user/.java'
    $java_prefs_user_root     = '/home/wso2user/.java/.systemPrefs'
    $java_home                = '/opt/java'

    # system configuration data
    $packages                 = [
      'zip',
      'unzip'
    ]

    $template_list        = [
      'repository/conf/datasources/bps-datasources.xml',
      'repository/conf/datasources/metrics-datasources.xml',
      'repository/conf/identity/identity.xml',
      'repository/conf/identity/sso-idp-config.xml',
      'repository/conf/identity/application-authentication.xml',
      'repository/conf/identity/EndpointConfig.properties',
      'repository/conf/carbon.xml',
      'repository/conf/user-mgt.xml',
      'repository/conf/registry.xml',
      'repository/conf/datasources/master-datasources.xml',
      'repository/conf/tomcat/catalina-server.xml',
      'repository/conf/axis2/axis2.xml',
      'repository/conf/security/authenticators.xml',
      'bin/wso2server.sh'
    ]

    $hosts_mapping            = {
      localhost => {
        ip   => '127.0.0.1',
        name => 'localhost'
      }
    }

    $master_datasources       = {
      wso2_carbon_db => {
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
    }

    $carbon_home_symlink      = "/mnt/${product_name}-${product_version}"
    $wso2_user                = 'wso2user'
    $wso2_group               = 'wso2'
    $maintenance_mode         = 'refresh'
    $install_mode             = 'file_bucket'
    $install_dir              = "/mnt/${ipaddress}"
    $pack_dir                 = '/mnt/packs'
    $pack_filename            = "${product_name}-${product_version}.zip"
    $pack_extracted_dir       = "${product_name}-${product_version}"
    $hostname                 = 'localhost'
    $mgt_hostname             = 'localhost'
    $worker_node              = false
    $patches_dir              = 'repository/components/patches'
    $service_name             = $product_name
    $service_template         = 'wso2base/wso2service.erb'
    $usermgt_datasource       = 'wso2_carbon_db'
    $local_reg_datasource     = 'wso2_carbon_db'
    $identity_datasource      = 'wso2_carbon_db'
    $bps_datasource           = 'bps_ds'
    $metrics_datasource       = 'wso2_metrics_db'

    $clustering               = {
      enabled           => false,
      membership_scheme => 'wka',
      domain            => 'wso2.carbon.domain',
      local_member_host => '127.0.0.1',
      local_member_port => '4000',
      sub_domain        => 'mgt',
      wka               => {
        members => [
          {
            hostname => '127.0.0.1',
            port     => 4000
          }
        ]
      }
    }
    $session_persist       = {
      enabled           => true,
      temporary         => true,
      pool_size         => 0
    }

    $session_cleanUp       = {
      enabled           => true,
      timeout           => 20160,
      period            => 1140,
      delete_chunk_size => 50000
    }

    $operation_cleanUp       = {
      enabled           => true,
     }

    $openID       = {
      skip_user_consent => false,
      remember_me_timeout  => 7200,
      disable_dumbmode   => false,
      remember_me_expir => 7200

    }

    $time_config       = {
      session_idle_timeout => 15,
      remember_me_timeout  => 20160
    }

    $oAuth      = {
      app_info_cache_timeout => -1,
      auth_grant_cache_timeout  => -1,
      session_data_cache_timeout   => -1,
      claim_cache_timeout   => -1,
      auth_code_default_validity_period => 300,
      access_token_default_validity_period => 3600,
      user_access_token_default_validity_period   => 3600,
      refresh_token_validity_period  =>84600,
      time_stamp_skew   => 0,
      renew_refresh_token_for_refresh_grant => true,
      strict_client_credential_validation   => false,
      enable_assertions_UserName => false,
      enable_access_token_partitioning => false,
      auth_context_token_generation_enabled => false,
      auth_context_token_generation_TTL => 15,
      id_token_expiration => 3600,
      openIDConnect_skip_user_consent => false,
      sign_jwt_spey => false,
      token_persistence_enable => true,
      token_persistence_pool_size => 0,
      token_persistence_retry_count => 5
    }

    $sso      = {
      persistance_cache_timeout => 157680000,
      session_index_timeout  => 157680000,
      single_logout_retry_count  => 5,
      single_logout_retry_interval   => 60000,
      sAMLresponse_validity_period=> 5,
      use_authenticated_user_domain_crypto => false,
      slo_host_name_verifi_enabled => true,
      tenant_partitioning_enabled => false
    }

    $passiveSTS      = {
      slo_host_name_verifi_enabled => true
    }

    $evenet_listeners     = {
      user_store_action_listener => true,
      identity_mgt_event_listener => false,
      identity_governance_event_listener => true,
      scimuser_operation_listener => true,
      identity_store_event_listener => true,
      daslogin_data_publisher => false,
      dassession_data_publisher => false,
      authn_data_publisher_proxy => true,
      identity_scim2_user_operation_listener => false
    }

    $cache      = {
      appauth_framework_session_context             => true,
      authentication_context_cache                  => true,
      authentication_request_cache                  => true,
      app_info_cache                                => true,
      authorization_grant_cache                     => true,
      oauth_cache                                   => true,
      oauth_scope_cache                             => true,
      oauth_session_data_cache                      => true,
      samalsso_participant_cache                    => true,
      samalsso_session_index_cache                  => true,
      samalsso_session_data_cache                   => true,
      service_provider_cache                        => true,
      provisioning_connector_cache                  => true,
      provisioning_entity_cache                     => true,
      service_provider_provisioning_connector_cache => true,
      idP_cache_byauth_property                     => true,
      idp_cache_byhri                               => true,
      idp_cache_by_name                             => true
    }
    $dep_sync                 = {
      enabled => false
    }

    $ports                    = {
      offset => 0
    }

    $jvm                      = {
      xms           => '256m',
      xmx           => '1024m',
      max_perm_size => '256m'
    }

    $sso_authentication       = {
      enabled => false
    }

    $user_management          = {
      add_admin       => 'true',
      admin_role      => 'admin',
      admin_username  => 'admin',
      admin_password  => 'admin',
      dataSource      => 'wso2_carbon_db'
    }

    $enable_secure_vault      = false

    $key_stores               = {
      key_store              => {
        location     => 'repository/resources/security/wso2carbon.jks',
        type         => 'JKS',
        password     => 'wso2carbon',
        key_alias    => 'wso2carbon',
        key_password => 'wso2carbon'
      },
      registry_key_store     => {
        location     => 'repository/resources/security/wso2carbon.jks',
        type         => 'JKS',
        password     => 'wso2carbon',
        key_alias    => 'wso2carbon',
        key_password => 'wso2carbon'
      },
      trust_store            => {
        location => 'repository/resources/security/client-truststore.jks',
        type     => 'JKS',
        password => 'wso2carbon'
      },
      connector_key_store    => {
        location => 'repository/resources/security/wso2carbon.jks',
        password => 'wso2carbon'
      },
      user_trusted_rp_store  => {
        location     => 'repository/resources/security/userRP.jks',
        type         => 'JKS',
        password     => 'wso2carbon',
        key_password => 'wso2carbon'
      }
    }
  }

  $product_name               = 'wso2is'
  $product_version            = '5.4.0'
  $platform_version           = '4.4.0'
  $carbon_home                = "${install_dir}/${product_name}-${product_version}"
  $pack_file_abs_path         = "${pack_dir}/${pack_filename}"
}