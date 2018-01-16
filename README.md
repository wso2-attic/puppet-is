# WSO2 Identity Server Puppet Modules

This repository contains following puppet modules related to WSO2 Identity Server.

1. wso2is   - WSO2 Identity Server 5.4.0
2. wso2is_analytics - WSO2 Identity Analytics Server 5.4.0

These modules support installing and configuring WSO2 Identity Server upon the two [standard production deployment 
patterns](https://docs.wso2.com/display/IS540/Deployment+Patterns) defined.
* Deployment Pattern 1: HA clustered deployment of WSO2 Identity Server
* Deployment Pattern 2: HA clustered deployment of WSO2 Identity Server with WSO2 Identity Analytics

Configuration data is managed using [Hiera](https://docs.puppet.com/hiera/1/). Hiera provides a mechanism for separating configuration data from Puppet 
scripts and managing them in a set of YAML files in a hierarchical manner.

This guide includes the basic and common information related to setting up puppet modules for deployment patterns 
above. Upon the modules used in each deployment pattern you may need to refer to the relevant ```README``` file under
 the hieradata directory of the respective module for the respective pattern.
> Note that this guide, explains only about setting up wso2is or wso2is_analytics puppet modules with respect to the 
deployment pattern selected. Setting up the infrastructure, load balancers and sharing runtime deployment artifacts 
among the nodes participating in a deployment is not in the scope of this guideline.
Refer [WSO2 Identity Server Deployment Guidelines](https://docs.wso2.com/display/IS540/Deploying+the+Identity+Server)
 to understand how to do a complete deployment of WSO2 Identity Server based on a standard deployment pattern.

## Supported Operating Systems
* Debian 6 or higher
* Ubuntu 14.04

## Supported Puppet Versions
* Puppet 3.x

## Setup Puppet Environment
Setup the puppet environment with puppet modules needed, with respect to the deployment pattern selected as defined 
below.
> Follow the steps mentioned in the [wiki](https://github.com/wso2/puppet-base/wiki) to setup a development environment.

* WSO2 IS 5.4.0 puppet modules are compatible and tested with puppet-base version 1.1.x and puppet-common version 1.0.x
* If using puppet-common's setup.sh to setup the PUPPET_HOME, use 1.0.x version of puppet-common.
* After setting up PUPPET_HOME using puppet-common's setup.sh, checkout the above mentioned compatible version of 
puppet-base.

##### Deployment Pattern 1   
* For this deployment pattern you need to setup wso2is and wso2base puppet modules following the guide in [wiki](https://github.com/wso2/puppet-base/wiki).

##### Deployment Pattern 2  
* For this deployment pattern you need to setup wso2is, wso2is_analytics, and wso2base puppet modules following the guide in [wiki](https://github.com/wso2/puppet-base/wiki).              
                                                        
## Copy artifacts
Upon the modules used based on the deployment pattern selected, copy necessary artifacts to the corresponding 
locations, in puppet master.

##### Deployment Pattern 1  
1. Copy JDK jdk-8u*-linux-x64.tar.gz distribution to <PUPPET_HOME>/modules/wso2base/files
2. Copy WSO2 Identity Server 5.4.0 distribution (wso2is-5.4.0.zip) to <PUPPET_HOME>/modules/wso2is/files
3. Copy the JDBC driver as per the RDBMS used to <PUPPET_HOME>/modules/wso2is/files/configs/lib.  
                                   
##### Deployment Pattern 2
1. Copy JDK jdk-8u*-linux-x64.tar.gz distribution to <PUPPET_HOME>/modules/wso2base/files                
2. Copy WSO2 Identity Server 5.4.0 distribution (wso2is-5.4.0.zip) to <PUPPET_HOME>/modules/wso2is/files 
3. Copy WSO2 Identity Analytics Server 5.4.0 distribution (wso2is-analytics-5.4.0.zip) to <PUPPET_HOME>/modules/wso2is_analytics/files
4. Copy the JDBC driver as per the RDBMS used to <PUPPET_HOME>/modules/wso2is/files/configs/lib.
5. Copy the JDBC driver as per the RDBMS used to <PUPPET_HOME>/modules/wso2is_analytics/files/configs/lib.

## Configure Hiera

##### Deployment Pattern 1                                                                                                                                                          
* [Hiera YAML file](wso2is/hieradata/dev/wso2/wso2is/pattern-1/default.yaml) defined under pattern-1                                  
(wso2is/hieradata/dev/wso2/wso2is/pattern-1) directory of wso2is module includes configurations with respect to                        
this deployment pattern for WSO2 Identity Server. 
Configure hiera for WSO2 Identity Server following the [README](wso2is/hieradata/dev/wso2/wso2is/pattern-1/) under 
pattern-1 directory. 

##### Deployment Pattern 2                  
* [Hiera YAML file](wso2is/hieradata/dev/wso2/wso2is/pattern-2/default.yaml) defined under pattern-2            
(wso2is/hieradata/dev/wso2/wso2is/pattern-2) directory of wso2is module includes configurations with respect to 
this deployment pattern for WSO2 Identity Server. 
Configure hiera for WSO2 Identity Server following the [README](wso2is/hieradata/dev/wso2/wso2is/pattern-2/) under 
pattern-2 directory. 
* [Hiera YAML file](wso2is_analytics/hieradata/dev/wso2/wso2is_analytics/pattern-1/default.yaml) defined under pattern-1
(wso2is_analytics/hieradata/dev/wso2/wso2is_analytics/pattern-2) directory of wso2is_analytics module includes 
configurations with respect to this deployment pattern for WSO2 Identity Analytics Server. 
Configure hiera for WSO2 Identity Analytics Server following the [README](wso2is_analytics/hieradata/dev/wso2/wso2is_analytics/pattern-1/) under 
pattern-1 directory.

This completes setting up the puppet master


        
    
            

                                                                                     

                                                                                                                                       
                                                                                                                                       