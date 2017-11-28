# WSO2 Identity Server Pattern-0


This pattern can be used to deploy the stand alone WSO2 Identity Server, in a single node. In this deployment WSO2 
Identity Server will use the embedded H2 database.
Please note that this pattern is not production recommended and introduced such that it can be used to try out WSO2 
Identity Server deployment with puppet easily.

To use this pattern the /opt/deployment.conf file that needs to be configured in puppent agent should be as below:
```
product_name=wso2is
product_version=5.4.0
product_profile=default
environment=production
vm_type=openstack
use_hieradata=true
platform=default
pattern=pattern-0
```