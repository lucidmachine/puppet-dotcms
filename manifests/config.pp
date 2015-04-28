# == Class dotcms::config
#
# This class is called from dotcms for service config.
#
class dotcms::config(
  $root_plugin       = $::dotcms::root_plugin,
  $root_user         = $::dotcms::root_user,
  $root_group        = $::dotcms::root_group,
  $assets_root       = $::dotcms::assets_root,
  $assets_link       = $::dotcms::assets_link,
  $assets_target     = $::dotcms::assets_target,
  $java_home         = $::dotcms::java_home,
  $postgres_url      = $::dotcms::postgres_url,
  $postgres_username = $::dotcms::postgres_username,
  $postgres_password = $::dotcms::postgres_password,
) {

  file { $assets_root: 
    ensure => directory,
    owner  => $root_user,
    group  => $root_group,
  }

  file { $assets_link:
    ensure        => link,
    assets_target => $assets_target,
    backup        => false,
    force         => true,
  }

  file { "/etc/init.d/dotcmsd":
    ensure  => present,
    mode    => 0755,
    content => template('dotcms/dotcms_initd.erb')
  }

}
