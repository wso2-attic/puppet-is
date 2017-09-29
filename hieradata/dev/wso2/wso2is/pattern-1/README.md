#WSO2 IDENTITY SERVER Pattern-1


This pattern consist of a stand-alone IS setup with a single node deployment. The databases used in this pattern are the embedded H2 databases. The only difference between this pattern-1 and pattern-2 is that, pattern-1 uses embedded H2 databases and pattern-1 is configured to use external mysql databases.

Content of /opt/deployment.conf file should be similar to below to run the agent and setup this pattern in Puppet Agent.

product_name=wso2is
product_version=5.4.0
product_profile=default
environment=production
vm_type=openstack
use_hieradata=true
platform=default
pattern=pattern-1
