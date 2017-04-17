class dotcms::restart {

  Exec {
    path => $::path,
    cwd  => $::dotcms::server_path,
    refreshonly => true,
  }

  exec { 'Shutting down server for restart':
    command     => "$::dotcms::dotcms_path/bin/shutdown.sh",
    onlyif      => '/usr/bin/test -e /tmp/dotcms.pid',
  }

  exec { 'Starting up server for restart':
    command     => "$dotcms::dotcms_path/bin/startup.sh",
    require     => Exec['Shutting down server for restart']
  }

}
