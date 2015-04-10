# == Class dotcms::params
#
# This class is meant to be called from dotcms.
# It sets variables according to platform.
#
class dotcms::params {

  $root_plugin = '/opt/dotcms/dotserver/plugins/com.dotcms.config/ROOT'

  case $::osfamily {
    'Debian': {
      $package_name = 'dotcms'
      $service_name = 'dotcms'
    }
    'RedHat': {
      $package_name = 'dotcms'
      $service_name = 'dotcms'
    }
    'Amazon': {
      $package_name = 'dotcms'
      $service_name = 'dotcms'
      $root_user    = 'ec2-user'
      $root_group   = 'ec2-user'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
