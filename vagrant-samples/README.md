# Deploy WSO2 Identity Server and WSO2 Identity Analytics Server with Puppet using Vagrant

This guide walks through the steps needed to deploy WSO2 Identity Server and WSO2 Identity Analytics Server against 
each deployment pattern using Vagrant with VirtualBox as the provider.
Puppet will be used as the provisioning method in Vagrant and Hiera as the configuration data store.

## Prerequisites
* [Vagrant](https://www.vagrantup.com/)
* [Virtualbox](https://www.virtualbox.org/) Vagrant hypervisor

## Deployment Pattern 1
This will start two virtual machines. In each, WSO2 Identity Server is deployed with puppet and they are clustered. 

#### Setup a local puppet environment
1. Clone [puppet-common](https://github.com/wso2/puppet-common) repository and checkout version 1.0.x
    ```
    git clone https://github.com/wso2/puppet-common
    cd puppet-common
    git checkout v1.1.x
    ```
2. Create an empty directory and export the directory path as ```PUPPET_HOME```
    ```
    export PUPPET_HOME=<directory path>
    ```
    > From here onwards this directory path is referred as PUPPET_HOME in this guide.
3. Execute [setup.sh](https://github.com/wso2/puppet-common/blob/master/setup.sh) of cloned puppet-common repository 
to setup a local puppet environment for WSO2 Identity Server deployments, in the directory path exported before.
    ```
    # Checkouts the release tag into a detached HEAD state.
    ./setup.sh -p is -t v5.4.0.1
    ```
4. Go to ```wso2base``` module in ```PUPPET_HOME/modules/wso2base``` and checkout version 1.1.x of 
[puppet-base](https://github.com/wso2/puppet-base).
    ```
    cd PUPPET_HOME/modules/wso2base
    git checkout v1.1.x
    ```
5. Download and copy oracle JDK 1.8.0_131 (jdk-8u131-linux-x64.tar.gz) distribution to 
    ```<PUPPET_HOME>/modules/wso2base/files``` path.
    
    > If a different version of JDK is used you will have to update following entries of 
    ```PUPPET_HOME/modules/wso2base/hieradata/dev/wso2/common.yaml``` hiera file.
    ```
    wso2::java::installation_dir: /mnt/jdk-8u131
    wso2::java::source_file: jdk-8u131-linux-x64.tar.gz
    ```
6. Get the WUM updated version of WSO2 Identity Server 5.4.0. Rename the zip file to wso2is-5.4.0.zip and 
copy to ```<PUPPET_HOME>/modules/wso2is/files``` path.
7. Download MYSQL JDBC driver mysql-connector-java-5.1.36-bin.jar, and copy that to 
```<PUPPET_HOME>/modules/wso2is/files/configs/repository/components/lib``` path.

    > If a different version of MYSQL JDBC driver is used you will have to update following entries of 
```PUPPET_HOME/modules/wso2base/hieradata/dev/wso2/common.yaml``` hiera file.
    ```
    wso2::datasources::mysql::connector_jar: 'mysql-connector-java-5.1.36-bin.jar'
    ```

#### Setup MySQL Databases  
You need to setup databases externally. Each vagrant box should be able to connect to the MYSQL server.
> You can have a MYSQL server running in your local machine. In that case, make sure the connection user has access 
to the server from any of the virtual machines. May be for this guide you can have a connection user that can connect
 from any host and grant all privileges for databases.

> e.g:

> Create a connection user that can connect from any host via mysql client
```
mysql> CREATE USER 'wso2carbon'@'%' IDENTIFIED BY 'wso2carbon';
```
> Grant all privileges for the connection user to databases
```
mysql> GRANT ALL PRIVILEGES ON * . * TO 'wso2carbon'@'%';
```

1. Create ```WSO2_IDENTITY_DB``` and ```WSO2_USER_DB``` databases as below.
    ```
    mysql> CREATE DATABASE WSO2_IDENTITY_DB;
    mysql> CREATE DATABASE WSO2_USER_DB;
    ```
2. Get the WUM updated version of WSO2 Identity Server 5.4.0 and execute MYSQL scripts at following paths against 
```WSO2_IDENTITY_DB``` 

    For MYSQL 5.7 version and beyond,
    ```
    <PRODUCT_HOME>/dbscripts/mysql5.7.sql
    <PRODUCT_HOME>/dbscripts/identity/mysql-5.7.sql
    <PRODUCT_HOME>/dbscripts/bps/bpel/create/mysql.sql
    ```
    
    For MYSQL versions below 5.7
    ```
    <PRODUCT_HOME>/dbscripts/mysql.sql
    <PRODUCT_HOME>/dbscripts/identity/mysql.sql
    <PRODUCT_HOME>/dbscripts/bps/bpel/create/mysql.sql
    ```
    
    Executing scripts
    ```
    mysql> USE WSO2_IDENTITY_DB;
    mysql> SOURCE dbscripts/mysql5.7.sql;
    ```
3. Then execute following MYSQL script under WSO2 Identity Server 5.4.0 against ```WSO2_USER_DB```

    For MYSQL 5.7 version and beyond,
    ```
    <PRODUCT_HOME>/dbscripts/mysql5.7.sql
    ```
    
    For MYSQL versions below 5.7
    ```
    <PRODUCT_HOME>/dbscripts/mysql.sql
    ```
    
    Executing scripts
    ```
    mysql> USE WSO2_USER_DB;
    mysql> SOURCE dbscripts/mysql5.7.sql;
    ```

#### Configure Hiera
1. Open ```PUPPET_HOME/modules/wso2base/hieradata/dev/wso2/common.yaml``` file and update following entries with MYSQL 
server connection username and password.
    ```
    wso2::datasources::mysql::username: 'wso2carbon'
    wso2::datasources::mysql::password: 'wso2carbon'
    ```
2. Open ```PUPPET_HOME/modules/wso2is/hieradata/dev/wso2/wso2is/pattern-1/default.yaml``` file and update WKA 
clustering members as below.
    ```
    wso2::clustering:
      enabled: true
      local_member_host: "%{::ipaddress}"
      local_member_port: 4000
      domain: is.wso2.domain
    # WKA membership scheme
      membership_scheme: wka
      wka:
        members:
          -
            hostname: "192.168.100.111"
            port: 4000
          -
            hostname: "192.168.100.112"
            port: 4000
    ```
3. In the same file, update following entry with the MYSQL server connection hostname.
    > If  MYSQL server is running in host machine, give the IP address of the host.
     ```
     wso2::rdbms::hostname: 10.100.5.164
     ```

#### Run Vagrant
1. Copy [deployment-architecture-pattern-1-config.yaml](deployment-architecture-pattern-1-config.yaml) to 
```puppet-common/vagrant/``` path and rename that as ```config.yaml```
2. Go to ```puppet-common/vagrant/``` path and execute following command to start up virtual machines.
    ```
    vagrant up
    ```  

## Deployment Pattern 2
This will start four virtual machines. Two of them will have WSO2 Identity Server deployed and the other two will 
have WSO2 Identity Analytics Server deployed. WSO2 Identity Server nodes and WSO2 Identity Analytics Server are 
clustered.

#### Setup a local puppet environment
1. Clone [puppet-common](https://github.com/wso2/puppet-common) repository and checkout version 1.0.x
    ```
    git clone https://github.com/wso2/puppet-common
    cd puppet-common
    git checkout v1.1.x
    ```
2. Create an empty directory and export the directory path as ```PUPPET_HOME```
    ```
    export PUPPET_HOME=<directory path>
    ```
    > From here onwards this directory path is referred as PUPPET_HOME in this guide.
3. Execute [setup.sh](https://github.com/wso2/puppet-common/blob/master/setup.sh) of cloned puppet-common repository 
to setup a local puppet environment for WSO2 Identity Server deployments, in the directory path exported before.
    ```
    # Checkouts the release tag into a detached HEAD state.
    ./setup.sh -p is -t v5.4.0.1
    ```
4. Go to ```wso2base``` module in ```PUPPET_HOME/modules/wso2base``` and checkout version 1.1.x of 
[puppet-base](https://github.com/wso2/puppet-base).
    ```
    cd PUPPET_HOME/modules/wso2base
    git checkout v1.1.x
    ```
5. Download and copy oracle JDK 1.8.0_131 (jdk-8u131-linux-x64.tar.gz) distribution to 
```<PUPPET_HOME>/modules/wso2base/files``` path.

    > If a different version of JDK is used you will have to update following entries of 
    ```PUPPET_HOME/modules/wso2base/hieradata/dev/wso2/common.yaml``` hiera file.
    ```
    wso2::java::installation_dir: /mnt/jdk-8u131
    wso2::java::source_file: jdk-8u131-linux-x64.tar.gz
    ```
6. Get the WUM updated version of WSO2 Identity Server 5.4.0. Rename the zip file to wso2is-5.4.0.zip and 
copy to ```<PUPPET_HOME>/modules/wso2is/files``` path.
7. Download MYSQL JDBC driver mysql-connector-java-5.1.36-bin.jar, and copy that to 
```<PUPPET_HOME>/modules/wso2is/files/configs/repository/components/lib``` path.
    > If a different version of MYSQL JDBC driver is used you will have to update following entries of 
    ```PUPPET_HOME/modules/wso2base/hieradata/dev/wso2/common.yaml``` hiera file.
    ```
    wso2::datasources::mysql::connector_jar: 'mysql-connector-java-5.1.36-bin.jar'
    ```
8. Get the WUM updated version of WSO2 Identity Analytics Server 5.4.0. Rename the zip file to wso2is-analytics-5.4.0
.zip and copy to ```<PUPPET_HOME>/modules/wso2is_analytics/files``` path.
9. Copy MYSQL JDBC driver mysql-connector-java-5.1.36-bin.jar, to 
   ```<PUPPET_HOME>/modules/wso2is_analytics/files/configs/repository/components/lib``` path.

#### Setup MySQL Databases  
You need to setup databases externally. Each vagrant box should be able to connect to the MYSQL server.
> You can have a MYSQL server running in your local machine. In that case, make sure the connection user has access 
to the server from any of the virtual machines. May be for this guide you can have a connection user that can connect
 from any host and grant all privileges for databases.

> e.g:

> Create a connection user that can connect from any host via mysql client
```
mysql> CREATE USER 'wso2carbon'@'%' IDENTIFIED BY 'wso2carbon';
```
> Grant all privileges for the connection user to databases
```
mysql> GRANT ALL PRIVILEGES ON * . * TO 'wso2carbon'@'%';
```

1. Create ```WSO2_IDENTITY_DB``` and ```WSO2_USER_DB``` databases as below.
    ```
    mysql> CREATE DATABASE WSO2_IDENTITY_DB;
    mysql> CREATE DATABASE WSO2_USER_DB;
    ```
2. Get the WUM updated version of WSO2 Identity Server 5.4.0 and execute MYSQL scripts at following paths against 
```WSO2_IDENTITY_DB``` 

    For MYSQL 5.7 version and beyond,
    ```
    <PRODUCT_HOME>/dbscripts/mysql5.7.sql
    <PRODUCT_HOME>/dbscripts/identity/mysql-5.7.sql
    <PRODUCT_HOME>/dbscripts/bps/bpel/create/mysql.sql
    ```
    
    For MYSQL versions below 5.7
    ```
    <PRODUCT_HOME>/dbscripts/mysql.sql
    <PRODUCT_HOME>/dbscripts/identity/mysql.sql
    <PRODUCT_HOME>/dbscripts/bps/bpel/create/mysql.sql
    ```
    
    Executing scripts
    ```
    mysql> USE WSO2_IDENTITY_DB;
    mysql> SOURCE dbscripts/mysql5.7.sql;
    ```
3. Then execute following MYSQL script under WSO2 Identity Server 5.4.0 against ```WSO2_USER_DB```

    For MYSQL 5.7 version and beyond,
    ```
    <PRODUCT_HOME>/dbscripts/mysql5.7.sql
    ```
    
    For MYSQL versions below 5.7
    ```
    <PRODUCT_HOME>/dbscripts/mysql.sql
    ```
    
    Executing scripts
    ```
    mysql> USE WSO2_USER_DB;
    mysql> SOURCE dbscripts/mysql5.7.sql;
    ```
4. Create ```WSO2_ANALYTICS_DB```, ```WSO2_ANALYTICS_EVENT_STORE_DB``` and ```WSO2_ANALYTICS_PROCESSED_DATA_STORE_DB``` databases as below.
    ```
    mysql> CREATE DATABASE WSO2_ANALYTICS_DB;
    mysql> CREATE DATABASE WSO2_ANALYTICS_EVENT_STORE_DB;
    mysql> CREATE DATABASE WSO2_ANALYTICS_PROCESSED_DATA_STORE_DB;
    ```
5. Get the WUM updated version of WSO2 Identity Analytics Server 5.4.0 and execute MYSQL script at following path 
against ```WSO2_ANALYTICS_DB``` 

    For MYSQL 5.7 version and beyond,
    ```
    <PRODUCT_HOME>/dbscripts/mysql5.7.sql
    ```
    
    For MYSQL versions below 5.7
    ```
    <PRODUCT_HOME>/dbscripts/mysql.sql
    ```
    
    Executing scripts
    ```
    mysql> USE WSO2_ANALYTICS_DB;
    mysql> SOURCE dbscripts/mysql5.7.sql;
    ```
    
#### Configure Hiera
1. Open ```PUPPET_HOME/modules/wso2base/hieradata/dev/wso2/common.yaml``` file and update following entries with MYSQL 
server connection username and password.
    ```
    wso2::datasources::mysql::username: 'wso2carbon'
    wso2::datasources::mysql::password: 'wso2carbon'
    ```
2. Open ```PUPPET_HOME/modules/wso2is/hieradata/dev/wso2/wso2is/pattern-2/default.yaml``` file and update WKA 
clustering members as below.
    ```
    wso2::clustering:
      enabled: true
      local_member_host: "%{::ipaddress}"
      local_member_port: 4000
      domain: is.wso2.domain
    # WKA membership scheme
      membership_scheme: wka
      wka:
        members:
          -
            hostname: "192.168.100.111"
            port: 4000
          -
            hostname: "192.168.100.112"
            port: 4000
    ```
3. In the same file, update following entry with the MYSQL server connection hostname.
    > If  MYSQL server is running in host machine, give the IP address of the host.
     ```
     wso2::rdbms::hostname: 10.100.5.164
     ```
4. In the same file, update following entries to configure failover load balancing to publish data to WSO2 Identity 
Analytics nodes.
    ```
    wso2::analytics_receiver_url: "{tcp://192.168.100.113:7611|tcp://192.168.100.114:7611}"
    wso2::analytics_authenticator_url: "{tcp://192.168.100.113:7711|tcp://192.168.100.114:7711}"
    ```
4. Open ```PUPPET_HOME/modules/wso2is_analytics/hieradata/dev/wso2/wso2is_analytics/pattern-1/default.yaml``` file and 
update WKA clustering members as below.
    ```
    wso2::clustering:
      enabled: true
      local_member_host: "%{::ipaddress}"
      local_member_port: 4000
      domain: is.wso2.domain
    # WKA membership scheme
      membership_scheme: wka
      wka:
        members:
          -
            hostname: "192.168.100.113"
            port: 4000
          -
            hostname: "192.168.100.114"
            port: 4000
    ```
5. In the same file, update following entry with the MYSQL server connection hostname.
    > If  MYSQL server is running in host machine, give the IP address of the host.
     ```
     wso2::rdbms::hostname: 10.100.5.164
     ```
     
#### Run Vagrant
1. Copy [deployment-architecture-pattern-2-config.yaml](deployment-architecture-pattern-2-config.yaml) to 
```puppet-common/vagrant/``` path and rename that as ```config.yaml```
2. Go to ```puppet-common/vagrant/``` path and execute following command to start up virtual machines.
    ```
    vagrant up
    ```         
                                                                                                                                     