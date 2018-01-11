# WSO2 Identity Server 5.4.0 Puppet Modules

This repository contains following puppet modules related to WSO2 Identity Server.

1. wso2is   - WSO2 Identity Server 5.4.0
2. wso2is_analytics - WSO2 Identity Analytics Server 5.4.0

These modules support installing and configuring WSO2 Identity Server upon the two [standard production deployment 
patterns](https://docs.wso2.com/display/IS540/Deployment+Patterns) defined.
Configuration data is managed using [Hiera](https://docs.puppet.com/hiera/1/). Hiera provides a mechanism for separating configuration data from Puppet 
scripts and managing them in a set of YAML files in a hierarchical manner.

This guide includes the the basic and common information related to each deployment pattern. Follow the instructions here, to setup any deployment pattern. For specific information on each pattern, refer the relevant README file in each pattern related hieradata directory (i.e. for pattern 5 : puppet-ei/hieradata/dev/wso2/wso2ei/pattern-5/README.md)