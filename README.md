# nagios_config Module
[![Build Status](https://travis-ci.org/Adaptavist/puppet-nagios_config.svg?branch=master)](https://travis-ci.org/Adaptavist/puppet-nagios_config)

## Overview

The **nagios_config** module handles the configuration of nagios hosts specifically it allows custom host variables to be set in the host definition, a usefull nagios feature that is missing from the core nagios_host type.
It is designed to be used alongside the ***thias/puppet-nagios*** puppet module

### Configuration

`nagios_service`

The name of the nagios service, defaults to the value of the ***thias/puppet-nagios*** puppet module variable **$nagios::server::nagios_service**

`$host_config_directory`

The location where host config files should be created, defaults to **/etc/nagios3/conf.d/hosts**

`$service_config_directory`

The location where service config files should be created, defaults to **/etc/nagios3/conf.d/services**

`$purge_configs`

Flag to determine if any unmanaged files in the hosts and serices config directorys should be deleted, defaults to **false**

`$directory_owner`

The owner of the hosts config directory, defult to **nagios**

`$directory_group` 

The group of the hosts config directory, defult to **nagios**

`$hosts`                 = {}

A hash of host configurations to create, default to **empty hash**

`$services`                 = {}

A hash of service configurations to create, default to **empty hash**

##Hiera Examples:


    nagios_config::host_config_directory: '/etc/nagios3/conf.d/hosts'
    nagios_config::service_config_directory: '/etc/nagios3/conf.d/services'
    nagios_config::purge_configs: true
    nagios_config::hosts:
        "test-server.example.com":
            alias: "Test Server"
            address: "192.168.1.254"
            check_command: "check-host-alive"
            contact_groups: "admins"
            check_interval: "5
            retry_interval: 1
            max_check_attempts: 5
            check_period: "24x7"
            process_perf_data: 0
            retain_nonstatus_information: 0
            notification_interval: 30
            notification_period: "24x7"
            notification_options: "d,u,r"
            hostgroups: "all-servers,linux-servers,mysql-servers"
            custom_variables: "%_DBUSER    dbuser1,_DBPASS     dbpass1"
            ensure: "present"
        


## Dependencies

This module depends on the thias/puppet-nagios module.