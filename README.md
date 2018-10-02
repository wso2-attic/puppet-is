# Puppet 5 Modules for WSO2 Identity Server 5.7.0

## Quick Start Guide
1. Download and copy the wso2is-linux-installer-x64-5.7.0.deb or wso2is-linux-installer-x64-5.7.0.rpm to the files folder in /etc/puppet/code/environments/dev/modules/is/files in the Puppetmaster.
Dev refers to the sample environment that you can try this modules.

2. Run the following commands in the Puppet agent

```
export FACTER_profile=is

puppet agent -vt
```
