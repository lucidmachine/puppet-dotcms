class dotcms::reindex {

  Exec {
    path => $::path,
    cwd  => $::dotcms::application_path,
    refreshonly => true,
  }

  file {"${::dotcms::application_path}/postgres_host":
    ensure  => present,
    content => $::dotcms::postgres_host,
    notify  => Exec['Delete esdata Cache']
  }

  # Before reindexing we need to clean up cache:
  exec {'Delete esdata Cache':
    command => "rm -rf ${::dotcms::application_path}/dotsecure/esdata/*",
    notify  => Exec['Delete h2db Cache']
  }

  exec {'Delete h2db Cache':
    command => "rm -rf ${::dotcms::application_path}/dotsecure/h2db/*",
    notify  => Exec['Execute Reindex'],
    require => Exec['Delete esdata Cache']
  }

  # Start Reindex
  exec {'Execute Reindex':
    command => "echo 'no reindex script yet'",
    require => Exec['Delete h2db Cache']
  }

}
