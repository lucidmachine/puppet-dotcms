class dotcms::restart {

  Exec {
    path => $::path,
    cwd  => $::dotcms::server_path,
    refreshonly => true,
  }

  exec { 'Shutting down server for restart':
    command     => "$::dotcms::dotcms_path/bin/shutdown.sh",
    returns     => [0, 1]
  }

  exec { 'Starting up server for restart':
    command     => "$dotcms::dotcms_path/bin/startup.sh",
    require     => Exec['Shutting down server for restart']
  }

}
