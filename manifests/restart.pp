class dotcms::restart{

  Exec {
    path => $::path,
    cwd  => $::dotcms::server_path,
    refreshonly => true,
  }

  exec {'Shuting down server':
    command     => "$::dotcms::server_path/bin/shutdown.sh",
  }

  exec{'Starting up server':
    command     => "$dotcms::server_path/bin/startup.sh",
    require     => Exec['Shuting down server']
  }

}
