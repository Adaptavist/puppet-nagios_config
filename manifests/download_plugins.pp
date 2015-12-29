# = Class: nagios_config::download_plugins
#

class nagios_config::download_plugins(
    $plugins    = {},
    ) {

    create_resources('nagios::custom_plugin',  $plugins)
}