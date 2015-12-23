class nagios_config (
    $nagios_service           = $nagios::server::nagios_service,
    $host_config_directory    = '/etc/nagios3/conf.d/hosts',
    $service_config_directory = '/etc/nagios3/conf.d/services',
    $purge_configs            = false,
    $directory_owner          = 'nagios',
    $directory_group          = 'nagios',
    $hosts                    = {},
    $services                 = {},
    ) {

    # work out if we should be purging the host config dir of unmanaged files or not
    if str2bool($purge_host_configs) {
        $real_purge = true
    } else {
        $real_purge = false
    }

    # ensure the directory that will house the host config files exists
    file { $host_config_directory:
        ensure  => 'directory',
        recurse => true,
        purge   => $real_purge,
        owner   => $directory_owner,
        group   => $directory_group,
    }

    # ensure the directory that will house the service config files exists
    file { $service_config_directory:
        ensure  => 'directory',
        recurse => true,
        purge   => $real_purge,
        owner   => $directory_owner,
        group   => $directory_group,
    }

    # create a config file per host as defined in the hosts hash
    create_resources (nagios_config::nagios_extended_host, $hosts)

    # create a config file per service as defined in the services hash
    create_resources (nagios_config::nagios_extended_service, $services)
    }
