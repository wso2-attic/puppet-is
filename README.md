# WSO2 Identity Server Puppet Module

This repository contains the Puppet Module for installing and configuring WSO2 Identity Server on various environments. It supports multiple versions of WSO2 Identity Server. Configuration data is managed using [Hiera](http://docs.puppetlabs.com/hiera/1/). Hiera provides a mechanism for separating configuration data from Puppet scripts and managing them in a separate set of YAML files in a hierarchical manner.

## Supported Operating Systems

- Debian 6 or higher
- Ubuntu 12.04 or higher

## Supported Puppet Versions

- Puppet 2.7, 3 or newer

## How to Contribute
Follow the steps mentioned in the [wiki](https://github.com/wso2/puppet-base/wiki) to setup a development environment and update/create new puppet modules.

## Packs to be Copied

Copy the following files to their corresponding locations.

1. WSO2 Identity Server distribution (5.3.0) to `<PUPPET_HOME>/modules/wso2is/files`
2. JDK 1.7_80 distribution to `<PUPPET_HOME>/modules/wso2base/files`

Note: For wso2is_km puppet module use WSO2 Identity Server 5.3.0 distribution which has API Key Manager feature installed on it. If you are using the pre-packaged [WSO2 Identity Server 5.3.0 Key Manager pack](http://product-dist.wso2.com/downloads/api-manager/1.10.0/identity-server/wso2is-5.3.0.zip) with Secure Vault enabled, extract the product zip file, remove `authenticationendpoint` folder in `CARBON_HOME/repository/deployment/server/webapps`, compress the pack and then copy it to `<PUPPET_HOME>/modules/wso2is_km/files`. For more details, refer step 4 under `Running  WSO2 Identity Server Key Manager with Secure Vault`.

## Running WSO2 Identity Server in the `default` profile
No changes to Hiera data are required to run the `default` profile.  Copy the above mentioned files to their corresponding locations and apply the Puppet Modules.

## Running WSO2 Identity Server with clustering in specific profiles
No changes to Hiera data are required to run the distributed deployment of WSO2 Identity Server, other than pointing to the correct resources such as the deployment synchronization and remote DB instances. For more details refer the [WSO2 Identity Server 5.3.0](https://docs.wso2.com/display/CLUSTER44x/Clustering+Identity+Server+5.3.0) and [WSO2 Identity Server 5.0.0](https://docs.wso2.com/display/CLUSTER420/Clustering+Identity+Server) clustering guides.

1. If the Clustering Membership Scheme is `WKA`, add the Well Known Address list.

   Ex:
    ```yaml
    wso2::clustering :
        enabled: true
        local_member_host: "%{::ipaddress}"
        local_member_port: 4000
        membership_scheme: wka
        sub_domain: mgt
        wka:
           members:
             -
               hostname: 192.168.100.113
               port: 4000
             -
               hostname: 192.168.100.114
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
        url: jdbc:mysql://mysql-is-db:3306/IS_DB?autoReconnect=true
        username: "%{hiera('wso2::datasources::common::username')}"
        password: "%{hiera('wso2::datasources::common::password')}"
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
      target_path: /_system/config
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

## Running WSO2 Identity Server with Secure Vault
WSO2 Carbon products may contain sensitive information such as passwords in configuration files. [WSO2 Secure Vault](https://docs.wso2.com/display/Carbon444/Securing+Passwords+in+Configuration+Files) provides a solution for securing such information.

>For WSO2 Identity Server 5.0.0, which is based on WSO2 Carbon Kernel 4.2.0, `org.wso2.ciphertool-1.0.0-wso2v2.jar` in Kernel patch [patch0010](http://dist.wso2.org/maven2/org/wso2/carbon/WSO2-CARBON-PATCH-4.2.0/0010/) has to be applied before enabling the Secure Vault. The `org.wso2.ciphertool-1.0.0-wso2v2.jar` in `WSO2-CARBON-PATCH-4.2.0-0009/lib` has to be copied to `wso2is/files/configs/lib` folder and added to the `file_list` in hiera file as below:

```yaml
wso2::file_list :
  - lib/org.wso2.ciphertool-1.0.0-wso2v2.jar
```

Uncomment and modify the below changes in Hiera file to apply Secure Vault.

1. Enable Secure Vault

    ```yaml
    wso2::enable_secure_vault: true
    ```

2. Run the ciphertool.sh / ciphertool.bat (in <WSO2_HOME>/bin) with -Dconfigure parameter and enter the primary keystore password of carbon server.

```bash
sh ciphertool.sh -Dconfigure
[Please Enter Primary KeyStore Password of Carbon Server : ]

```

3. Copy repository/conf/security/cipher-tool.properties, repository/conf/security/cipher-text.properties, repository/conf/security/secret-conf.properties in <WSO2_HOME>/repository/conf/security to 
'/etc/puppet/environments/production/modules/wso2is/files/configs/repository/conf/security'

4. Create a file named 'password-tmp' containing the the primary keystore password of carbon server in 
'/etc/puppet/environments/production/modules/wso2is/files/configs'

5. Add the following configurations
   
```yaml
# Puppet file list to be populated
 wso2::file_list:
  - repository/conf/security/cipher-tool.properties
  - repository/conf/security/cipher-text.properties
  - repository/conf/security/secret-conf.properties

# Puppet file list to be populated without triggering refresh
wso2::file_list_copy_without_refresh:
  - password-tmp
```

## Running WSO2 Identity Server on Kubernetes
WSO2 Puppet Module ships Hiera data required to deploy WSO2 Identity Server on Kubernetes. For more information refer to the documentation on [deploying WSO2 products on Kubernetes using WSO2 Puppet Modules](https://docs.wso2.com/display/PM210/Deploying+WSO2+Products+on+Kubernetes+Using+WSO2+Puppet+Modules).
