class dotcms::plugin::reload{

  exec {'Shuting down server':
    command     => "$::dotcms::server_path/bin/shutdown.sh",
    path        => $::path,
    refreshonly => true,
  }

  exec {'Deploying plugins':
    command     => "$dotcms::server_path/bin/deploy-plugins.sh",
    path        => $::path,
    refreshonly => true,
    require     => Exec['Shuting down server']
  }

  exec{'Starting up server':
    command     => "$dotcms::server_path/bin/startup.sh",
    path        => $::path,
    refreshonly => true,
    require     => Exec['Deploying plugins']
  }

}
