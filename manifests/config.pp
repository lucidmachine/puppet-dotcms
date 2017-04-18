# == Class dotcms::config
#
# This class is called from dotcms for service config.
#
class dotcms::config(
  $assets_link   = $::dotcms::assets_link,
  $assets_target = $::dotcms::assets_target,
  $tomcat_path   = $::dotcms::tomcat_path,
) {

  file { $assets_target: 
    ensure => directory,
  }

  file { $assets_link:
    ensure  => link,
    target  => $assets_target,
    backup  => false,
    force   => true,
    require => File[$assets_target]
  }

  file { "$tomcat_path/bin/setenv.sh":
    ensure  => present,
    mode    => 0755,
    content => template('dotcms/setenv.sh.erb')
  }

}
