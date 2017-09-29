#WSO2 IDENTITY SERVER Pattern-4

 Registry Mounting using one DB and multiple Registry spaces as bellow



This pattern consist of a stand-alone IS setup with a single node deployment. The databases used in this pattern are
external MYSQL databases and also registry mounting  is done using a one shared registry database,  registry spaces are
use for config and governance registry.
mounter seprately.

Content of /opt/deployment.conf file should be similar to below to run the agent and setup this pattern in Puppet Agent.

product_name=wso2is
product_version=5.4.0
product_profile=default
environment=production
vm_type=openstack
use_hieradata=true
platform=default
pattern=pattern-2
