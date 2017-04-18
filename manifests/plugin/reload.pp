class dotcms::plugin::reload (
  $dotcms_path        = $::dotcms::dotcms_path,
  $dotcms_distro_path = $::dotcms::dotcms_distro_path,
) {

  Exec {
    path => $::path,
    cwd  => $dotcms_path,
    refreshonly => true,
  }

  exec { 'Shutting down server':
    command => "${dotcms_distro_path}/bin/shutdown.sh",
    returns => [0, 1]
  }

  exec { 'Undeploying plugins':
    command => "${dotcms_distro_path}/bin/undeploy-plugins.sh",
    require => Exec['Shutting down server']
  }

  exec { 'Deploying plugins':
    command => "${dotcms_distro_path}/bin/deploy-plugins.sh",
    require => Exec['Undeploying plugins']
  }

  exec{ 'Starting up server':
    command => "${dotcms_distro_path}/bin/startup.sh",
    require => Exec['Deploying plugins']
  }

}
