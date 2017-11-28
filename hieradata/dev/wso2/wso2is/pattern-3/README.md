# WSO2 IDENTITY SERVER Pattern-5


This pattern consist of a clustered IS setup with a 2 node deployment. The databases used in this pattern are external
MYSQL databases with registry mounting.

Content of /opt/deployment.conf file should be similar to below to run the agent and setup this pattern in Puppet Agent.

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
