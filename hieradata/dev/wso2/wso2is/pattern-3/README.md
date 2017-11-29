# WSO2 Identity Server Pattern-3

This pattern can be used to deploy WSO2 Identity Server in a cluster. In this pattern datasources used in WSO2 Identity 
Server are externalized and registry mounting is used. 
Any external datasource of the supported database vendor types can be plugged to WSO2 Identity Server using this 
pattern. Default datasource related configurations are done with respect to MYSQL. 
Default configurations includes a two node clustered deployment with WKA membership scheme.
  
To use this pattern, configure the /opt/deployment.conf file in puppent agent as below:
```
product_name=wso2is
product_version=5.4.0
product_profile=default
environment=production
vm_type=openstack
use_hieradata=true
platform=default
pattern=pattern-3
```
