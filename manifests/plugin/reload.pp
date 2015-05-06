class dotcms::plugin::reload{

  Exec {
    path => $::path,
    cwd  => $::dotcms::server_path,
    refreshonly => true,
  }

  exec {'Shuting down server':
    command => "${::dotcms::server_path}/bin/shutdown.sh",
  }

  exec {'Undeploying plugins':
    command => "${::dotcms::server_path}/bin/undeploy-plugins.sh",
    require => Exec['Shuting down server']
  }

  exec {'Deploying plugins':
    command => "${dotcms::server_path}/bin/deploy-plugins.sh",
    require => Exec['Undeploying plugins']
  }

  exec{'Starting up server':
    command => "${dotcms::server_path}/bin/startup.sh",
    require => Exec['Deploying plugins']
  }

}
