# Define: nagios_config::nagios_extended_host

define nagios_config::nagios_extended_host (
    $nagios_service               = $nagios_config::nagios_service,
    $host_config_directory        = $nagios_config::host_config_directory,
    $directory_owner              = $nagios_config::directory_owner,
    $directory_group              = $nagios_config::directory_group,
    $check_period                 = '24x7',
    $check_command                = 'check-host-alive',
    $contact_groups               = 'admins',
    $notification_period          = '24x7',
    $check_interval               = 5,
    $max_check_attempts           = 5,
    $retry_interval               = 1,
    $notification_interval        = 30,
    $notification_options         = 'd,u,r',
    $process_perf_data            = 0,
    $retain_nonstatus_information = 0,
    $ensure                       = 'present',
    $server                       = undef,
    $custom_variables             = undef,
    $address                      = undef,
    $hostgroups                   = undef,
    $notes                        = undef,
    $notes_url                    = undef,
    $use                          = undef,
    $alias                        = undef,
) {

    case $ensure {
        'present': {
            file { "${host_config_directory}/${name}.cfg":
                ensure  => file,
                content => template("${module_name}/nagios_host.erb"),
                mode    => '0644',
                owner   => $directory_owner,
                group   => $directory_group,
                require => File[$host_config_directory],
                notify  => Service[$nagios_service],
            }
        }
        'absent': {
            file { "${host_config_directory}/${name}.cfg":
                ensure => 'absent',
                notify => Service[$nagios_service],
            }
        }
        default: {
          fail("${ensure} is not supported for ensure.  Allowed values are 'present' and 'absent'.")
        }
      }
}


