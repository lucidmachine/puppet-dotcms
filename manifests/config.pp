# == Class dotcms::config
#
# This class is called from dotcms for service config.
#
class dotcms::config(
  $root_plugin       = $::dotcms::root_plugin,
  $root_user         = $::dotcms::root_user,
  $root_group        = $::dotcms::root_group,
  $java_home         = $::dotcms::java_home,
  $postgres_url      = $::dotcms::postgres_url,
  $postgres_username = $::dotcms::postgres_username,
  $postgres_password = $::dotcms::postgres_password,
) {

  file { "/etc/init.d/dotcmsd":
    ensure  => present,
    mode    => 0755,
    content => template('dotcms/dotcms_initd.erb')
  }

  file { "$::dotcms::server_path/tomcat/bin/setenv.sh.erb":
    ensure  => present,
    content => template('dotcms/setenv.sh.erb')
  }

}
