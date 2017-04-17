class dotcms::restart {

  Exec {
    path => $::path,
    cwd  => $::dotcms::server_path,
    refreshonly => true,
  }

  exec { 'Shutting down server for restart':
    command     => "$::dotcms::dotcms_distro_path/bin/shutdown.sh",
    onlyif      => 'test -f /tmp/dotcms.pid',
    notify      => Exec['Starting up server for restart'],
  }

  exec { 'Starting up server for restart':
    command     => "$dotcms::dotcms_distro_path/bin/startup.sh",
  }

}
