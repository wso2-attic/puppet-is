# WSO2 Identity Server Pattern-1

This pattern can be used to deploy WSO2 Identity Server, in a single node. This deployment pattern modularizes the 
datasources used in WSO2 Identity Server deployment and includes registry mounting. Thus, any external datasource can
 be plugged to WSO2 Identity Server using this pattern. By default, the configurations are done with respect to MYSQL
  datasources.
  
To use this pattern the /opt/deployment.conf file that needs to be configured in puppent agent should be as below:
```
product_name=wso2is
product_version=5.4.0
product_profile=default
environment=production
vm_type=openstack
use_hieradata=true
platform=default
pattern=pattern-1
```
