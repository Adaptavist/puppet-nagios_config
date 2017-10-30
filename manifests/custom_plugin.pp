
# Define: nagios_config::custom_plugin
define nagios_config::custom_plugin (
    $local_path,
    $file_name,
    $gitrepo    = 'false',
    $plugin_url = 'false',
    $user       = 'root',
    $group      = 'root',
    $perms      = '755',
    ) {
    if ($gitrepo != 'false'){
        exec {
            "clone custom nagios plugin ${name} from gitrepo":
                command   => "git archive --format=tar --remote=${gitrepo} HEAD ${file_name} | tar xf -",
                cwd       => $local_path,
                logoutput => on_failure,
                unless    => ["test -f ${local_path}/${file_name}"],
        }
        Exec["clone custom nagios plugin ${name} from gitrepo"] -> Exec["change permissions to plugin file ${name}"]
    } elsif ($plugin_url != 'false') {
        exec {
            "wget nagios plugin ${name}":
            command => "/usr/bin/wget ${plugin_url}",
            cwd     => $local_path,
            unless  => ["test -f ${local_path}/${file_name}"],
        }

        Exec["wget nagios plugin ${name}"] -> Exec["change permissions to plugin file ${name}"]

    } else {
        fail('You have to provide gitrepo or plugin_url')
    }

    exec {
        "change permissions to plugin file ${name}":
            command   => "chown ${user}:${group} ${local_path}/${file_name} && chmod ${perms} ${local_path}/${file_name}",
            logoutput => on_failure,
    }
}
