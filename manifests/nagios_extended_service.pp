# Define: nagios_config::nagios_extended_service

define nagios_config::nagios_extended_service (
    $check_command,
    $service_description,
    $nagios_service               = $nagios_config::nagios_service,
    $service_config_directory     = $nagios_config::service_config_directory,
    $directory_owner              = $nagios_config::directory_owner,
    $directory_group              = $nagios_config::directory_group,
    $hostgroup_name               = undef,
    $host_name                    = undef,
    $use                          = undef,
    $check_period                 = undef,
    $contacts                     = undef,
    $contact_groups               = undef,
    $notification_period          = undef,
    $ensure                       = 'present',
    $active_checks_enabled        = '1',
    $check_freshness              = '0',                  
    $event_handler_enabled        = '1',
    $failure_prediction_enabled   = '1',
    $flap_detection_enabled       = '1',
    $is_volatile                  = '0',
    $max_check_attempts           = '3',
    $normal_check_interval        = '10',
    $notification_interval        = '60',
    $notification_options         = 'w,u,c,r',
    $notifications_enabled        = '1',
    $obsess_over_service          = '1',
    $parallelize_check            = '1',
    $passive_checks_enabled       = '1',
    $process_perf_data            = '1',
    $retain_nonstatus_information = '1',
    $retain_status_information    = '1',
    $retry_check_interval         = '2',
) {

    case $ensure {
        'present': {
            file { "${service_config_directory}/${name}.cfg":
                ensure  => file,
                content => template("${module_name}/nagios_service.erb"),
                mode    => '0644',
                owner   => $directory_owner,
                group   => $directory_group,
                require => File[$service_config_directory],
                notify  => Service[$nagios_service],
            }
        }
        'absent': {
            file { "${service_config_directory}/${name}.cfg":
                ensure => 'absent',
                notify => Service[$nagios_service],
            }
        }
        default: {
          fail("${ensure} is not supported for ensure.  Allowed values are 'present' and 'absent'.")
        }
      }
}


