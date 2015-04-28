class dotcms::restart{

  Exec {
    path => $::path,
    cwd  => $::dotcms::server_path,
    refreshonly => true,
  }

  exec {'Shuting down server for restart':
    command     => "$::dotcms::server_path/bin/shutdown.sh",
  }

  exec{'Starting up server for restart':
    command     => "$dotcms::server_path/bin/startup.sh",
    require     => Exec['Shuting down server for restart']
  }

}
