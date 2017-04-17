class dotcms::plugin::reload{

  Exec {
    path => $::path,
    cwd  => $::dotcms::dotcms_path,
    refreshonly => true,
  }

  exec { 'Shutting down server':
    command => "${::dotcms::dotcms_distro_path}/bin/shutdown.sh",
    returns => [0, 1]

  }

  exec { 'Undeploying plugins':
    command => "${::dotcms::dotcms_distro_path}/bin/undeploy-plugins.sh",
    require => Exec['Shutting down server']
  }

  exec { 'Deploying plugins':
    command => "${dotcms::dotcms_distro_path}/bin/deploy-plugins.sh",
    require => Exec['Undeploying plugins']
  }

  exec{ 'Starting up server':
    command => "${dotcms::dotcms_distro_path}/bin/startup.sh",
    require => Exec['Deploying plugins']
  }

}
