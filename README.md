# Puppet Modules for WSO2 Identity Server

This repository contains the Puppet modules for WSO2 Identity Server and the profiles related to Identity Server Analytics.

## Quick Start Guide
1. Download an updated wso2is-5.8.0.zip or wso2is-analytics-5.8.0.zip according to your preferred deployment pattern and copy it to the `<puppet_environment>/modules/common/files` directory in the **Puppetmaster**.

2. Set up the JDK distribution as follows:

   The Puppet modules for WSO2 products use Amazon Coretto as the JDK distribution. However, you can use any [supported JDK distribution](https://docs.wso2.com/display/compatibility/Tested+Operating+Systems+and+JDKs).
   1. Download Amazon Coretto for Linux x64 from [here](https://docs.aws.amazon.com/corretto/latest/corretto-8-ug/downloads-list.html) and copy .tar into the `<puppet_environment>/modules/common/files` directory.
   2. Reassign the *$jdk_name* variable in `<puppet_environment>/modules/<agent_module>/manifests/params.pp` to the name of the downloaded JDK distribution.
3. Identify the absolute path of the Puppet environment in the build script by renaming the *puppet_env* variable in `<puppet_environment>/modules/<master_module>/build.sh`.
4. Execute the build script.

    ```bash
    ./build.sh
    ```
5. Run the relevant profile on the **Puppet agent**.
    1. Identity Server profile:
        ```bash
        export FACTER_profile=is
        puppet agent -vt
        ```
    2. Analytics profile:
        1. Dashboard:
            ```bash
            export FACTER_profile=is_analytics_dashboard
            puppet agent -vt
            ```
        2. Worker:
            ```bash
            export FACTER_profile=is_analytics_worker
            puppet agent -vt
            ```

## Manifests in a module
The run stages for Puppet are described in `<puppet_environment>/manifests/site.pp`, and they are of the order Main -> Custom -> Final.

Each Puppet module contains the following .pp files.
* Main
    * params.pp: Contains all the parameters necessary for the main configuration and template
    * init.pp: Contains the main script of the module.
* Custom
    * custom.pp: Used to add custom configurations to the Puppet module.
* Final
    * startserver.pp: Runs at the end and starts the server as a linux service.
    