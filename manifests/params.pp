# == Class dotcms::params
#
# This class is meant to be called from dotcms.
# It sets variables according to platform.
#
class dotcms::params {

  $root_plugin       = '/opt/dotcms/dotserver/plugins/com.dotcms.config/ROOT'
  $postgres_url      = 'jdbc:postgresql://ipsy3-stagefromprod.crekj2abspyf.us-east-1.rds.amazonaws.com:5432/dotcms'
  $postgres_username = 'ipsy'
  $postgres_password = 'ipsytest'
  $java_home         = '/usr/local/java'
  $server_path       = '/opt/dotcms/dotserver'



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
