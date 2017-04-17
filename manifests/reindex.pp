class dotcms::reindex{

  Exec {
    path => $::path,
    cwd  => $::dotcms::dotcms_path,
    refreshonly => true,
  }

  file {"${::dotcms::dotcms_path}/postgres_host":
    ensure  => present,
    content => $::dotcms::postgres_host,
    notify  => Exec['delete esdata cache']
  }

  #Before reindeing we need to clean up cache:
  exec {'delete esdata cache':
    command => "rm -rf ${::dotcms::application_path}/dotsecure/esdata/*",
    notify  => Exec['delete h2db cache']
  }

  exec {'delete h2db cache':
    command => "rm -rf ${::dotcms::application_path}/dotsecure/h2db/*",
    notify  => Exec['execute reindex'],
    require => Exec['delete esdata cache']
  }

  # Start Reindex
  exec {'execute reindex':
    command => "echo 'no reindex script yet'",
    require => Exec['delete h2db cache']
  }

}
