class dotcms::plugin::reload{

  Exec {
    path => $::path,
    cwd  => $::dotcms::server_path,
    refreshonly => true,
  }

  exec {'Shuting down server':
    command     => "$::dotcms::server_path/bin/shutdown.sh",
  }

  exec {'Deploying plugins':
    command     => "$dotcms::server_path/bin/deploy-plugins.sh",
    require     => Exec['Shuting down server']
  }

  exec{'Starting up server':
    command     => "$dotcms::server_path/bin/startup.sh",
    require     => Exec['Deploying plugins']
  }

}
