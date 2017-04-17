class dotcms::plugin::reload{

  Exec {
    path => $::path,
    cwd  => $::dotcms::dotcms_path,
    refreshonly => true,
  }

  exec {'Shutting down server':
    command => "${::dotcms::dotcms_path}/bin/shutdown.sh",
    onlyif      => '/usr/bin/test -e /tmp/dotcms.pid',
  }

  exec {'Undeploying plugins':
    command => "${::dotcms::dotcms_path}/bin/undeploy-plugins.sh",
    require => Exec['Shutting down server']
  }

  exec {'Deploying plugins':
    command => "${dotcms::dotcms_path}/bin/deploy-plugins.sh",
    require => Exec['Undeploying plugins']
  }

  exec{'Starting up server':
    command => "${dotcms::dotcms_path}/bin/startup.sh",
    require => Exec['Deploying plugins']
  }

}
