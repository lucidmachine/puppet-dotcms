# == Class dotcms::params
#
# This class is meant to be called from dotcms.
# It sets variables according to platform.
#
class dotcms::params {

  $root_plugin       = '/opt/dotcms/dotserver/plugins/com.dotcms.config/ROOT'
  $postgres_host     = 'localhost'
  $postgres_port     = '5432'
  $postgres_username = 'ipsy'
  $postgres_password = 'ipsytest'
  $java_home         = '/usr/local/java'
  $server_path       = '/opt/dotcms/dotserver'
  $java_mem_max_size = '2G'
  $java_mem_perm_size = '4G'
  $assets_root = '/opt/dotcms/dotserver/dotCMS/assets'
  $assets_target = '/opt/dotcms/dotserver/dotCMS/assets'
  $assets_link = '/opt/dotcms/dotserver/dotCMS/assets_noused'

  case $::osfamily {
    'Debian': {
      $package_name = 'dotcms'
      $service_name = 'dotcms'
    }
    'RedHat', 'Linux': {
      $package_name = 'dotcms'
      $service_name = 'dotcms'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  case $::operatingsystem {
    'Amazon': {
      $root_user    = 'ec2-user'
      $root_group   = 'ec2-user'
    }
    default: {
      $root_user    = 'root'
      $root_group   = 'root'
    }
  }
}
