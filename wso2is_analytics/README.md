# WSO2 IS Analytics Server Puppet Module

This repository contains the Puppet Module for installing and configuring WSO2 IS Analytics Server on various
environments. It supports multiple versions of WSO2 Data Analytics Server. Configuration data is managed using [Hiera](http://docs.puppetlabs.com/hiera/1/). Hiera provides a mechanism for separating configuration data from Puppet scripts and managing them in a separate set of YAML files in a hierarchical manner.

## Supported Operating Systems

- Debian 6 or higher
- Ubuntu 12.04 or higher

## Supported Puppet Versions

- Puppet 3.x

## Setup Puppet Environment

* Setup the puppet environment with the puppet modules wso2is_analytics and wso2base.
* WSO2 IS Analytics 5.4.0 puppet module is compatible and tested with
[puppet-base](https://github.com/wso2/puppet-base/) version 1.2.0 and [puppet-common](https://github.com/wso2/puppet-common) version 1.1.0
* So if using puppet-common's setup.sh to setup the PUPPET_HOME, use this version (1.1.0) of puppet-common.
* After setting up PUPPET_HOME using puppet-common's setup.sh, checkout the above mentioned compatible version of puppet-base.

## Setup a Development Environment
Follow the steps mentioned in the [wiki](https://github.com/wso2/puppet-base/wiki) to setup a development environment and update/create new puppet modules.

## Packs to be Copied

Copy the following files to their corresponding locations, in the Puppet Master.

1. WSO2 IS Analytics Server 5.4.0 distribution (wso2is_analytics-5.4.0.zip) to 'PUPPET_HOME>/modules/wso2is_analytics/files`
2. JDK jdk-8u112-linux-x64.tar.gz distribution to `<PUPPET_HOME>/modules/wso2base/files`
3. (if using MySQL databases)MySQL JDBC driver JAR (mysql-connector-java-x.x.xx-bin.jar) into the <PUPPET_HOME>/modules/wso2is_analytics/files/configs/repository/components/lib
4. (if using svn based deployment synchronization)
    a. svnkit-all-1.8.7.wso2v1.jar into <PUPPET_HOME>/modules/wso2is_analytics/files/configs/repository/components/dropins
    b. trilead-ssh2-1.0.0-build215.jar into <PUPPET_HOME>/modules/wso2is_analytics/files/configs/repository/components/lib

## Running WSO2 IS Analytics Server in the `default` profile
No changes to Hiera data are required to run the `default` profile.  Copy the above mentioned files to their corresponding locations and apply the Puppet Modules.

## Running WSO2 IS Analytics Server with clustering in specific profiles
No changes to Hiera data are required to run the distributed deployment of WSO2 IS Analytics Server, other than
pointing to the correct resources such as the deployment synchronization and remote DB instances. For more details refer the [WSO2 Identity Server Deployment Patterns](https://docs.wso2.com/display/IS540/Deployment+Patterns)

1. If the Clustering Membership Scheme is `WKA`, add the Well Known Address list.

   Ex:
    ```yaml
    wso2::clustering:
        enabled: true
        local_member_host: "%{::ipaddress}"
        local_member_port: 4000
        membership_scheme: wka
        sub_domain: worker
        wka:
           members:
             -
               hostname: 192.168.100.63
               port: 4000
             -
               hostname: 192.168.100.64
               port: 4000
    ```

2. Add external databases to master datasources

   Ex:
    ```yaml
    wso2::master_datasources:
     wso2_config_db:
       name: WSO2_CONFIG_DB
       description: The datasource used for config registry
       driver_class_name: "%{hiera('wso2::datasources::mysql::driver_class_name')}"
       url: jdbc:mysql://192.168.100.1:3306/WSO2CONFIG_DB?autoReconnect=true
       username: "%{hiera('wso2::datasources::mysql::username')}"
       password: "%{hiera('wso2::datasources::mysql::password')}"
       jndi_config: jdbc/WSO2_CONFIG_DB
       max_active: "%{hiera('wso2::datasources::common::max_active')}"
       max_wait: "%{hiera('wso2::datasources::common::max_wait')}"
       test_on_borrow: "%{hiera('wso2::datasources::common::test_on_borrow')}"
       default_auto_commit: "%{hiera('wso2::datasources::common::default_auto_commit')}"
       validation_query: "%{hiera('wso2::datasources::mysql::validation_query')}"
       validation_interval: "%{hiera('wso2::datasources::common::validation_interval')}"

    ```

3. Configure registry mounting

   Ex:
    ```yaml
    wso2_config_db:
      path: /_system/config
      target_path: /_system/config/is-analytics
      read_only: false
      registry_root: /
      enable_cache: true

    wso2_gov_db:
      path: /_system/governance
      target_path: /_system/governance
      read_only: false
      registry_root: /
      enable_cache: true
    ```

4. Configure deployment synchronization

    Ex:
    ```yaml
    wso2::dep_sync:
        enabled: true
        auto_checkout: true
        auto_commit: true
        repository_type: svn
        svn:
           url: http://svnrepo.example.com/repos/
           user: username
           password: password
           append_tenant_id: true
    ```

## Running WSO2 IS Analytics Server with Secure Vault
WSO2 Carbon products may contain sensitive information such as passwords in configuration files. [WSO2 Secure Vault](https://docs.wso2.com/display/Carbon444/Securing+Passwords+in+Configuration+Files) provides a solution for securing such information.

Uncomment and modify the below changes in Hiera file to apply Secure Vault.

1. Enable Secure Vault

    ```yaml
    wso2::enable_secure_vault: true
    ```

2. Add Secure Vault configurations as below

    ```yaml
    wso2::secure_vault_configs:
      <secure_vault_config_name>:
        secret_alias: <secret_alias>
        secret_alias_value: <secret_alias_value>
        password: <password>
    ```

    Ex:
    ```yaml
    wso2::secure_vault_configs:
      key_store_password:
        secret_alias: Carbon.Security.KeyStore.Password
        secret_alias_value: repository/conf/carbon.xml//Server/Security/KeyStore/Password,false
        password: wso2carbon
    ```

3. Add Cipher Tool configuration file templates to `template_list`

    ```yaml
    wso2::template_list:
      - repository/conf/security/cipher-text.properties
      - repository/conf/security/cipher-tool.properties
      - bin/ciphertool.sh
    ```

    Please add the `password-tmp` template also to `template_list` if the `vm_type` is not `docker` when you are running the server in `default` platform.

## Running WSO2 IS Analytics Server on Kubernetes
WSO2 Puppet Module ships Hiera data required to deploy WSO2 IS Analytics Server on Kubernetes. For more information
refer to the documentation on [deploying WSO2 products on Kubernetes using WSO2 Puppet Modules](https://docs.wso2.com/display/PM210/Deploying+WSO2+Products+on+Kubernetes+Using+WSO2+Puppet+Modules).
