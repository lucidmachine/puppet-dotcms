class dotcms::reindex (
  $application_path = $::dotcms::application_path,
  $postgres_host    = $::dotcms::postgres_host,
) {

  Exec {
    path => $::path,
    cwd  => $application_path,
    refreshonly => true,
  }

  file {"$application_path/postgres_host":
    ensure  => present,
    content => $postgres_host,
    notify  => Exec['Delete esdata Cache']
  }

  # Before reindexing we need to clean up cache:
  exec {'Delete esdata Cache':
    command => "rm -rf ${application_path}/dotsecure/esdata/*",
    notify  => Exec['Delete h2db Cache']
  }

  exec {'Delete h2db Cache':
    command => "rm -rf ${application_path}/dotsecure/h2db/*",
    notify  => Exec['Execute Reindex'],
    require => Exec['Delete esdata Cache']
  }

  # Start Reindex
  # TODO: Make reindex script?
  exec {'Execute Reindex':
    command => "echo 'no reindex script yet'",
    require => Exec['Delete h2db Cache']
  }

}
