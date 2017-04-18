# == Class dotcms::params
#
# This class is meant to be called from dotcms.
# It sets variables according to platform.
#
class dotcms::params {
  $dotcms_version      = '3.7.1'

  $service_user        = 'dotcms'
  $service_group       = 'dotcms'
  $service_path        = '/var/run/dotcms'
  $service_pid_path    = "$::dotcms::params::service_path/dotcms.pid"

  $dotcms_pid_path     = '/tmp/dotcms.pid'
  $dotcms_path         = '/opt/dotcms'
  $dotcms_distro_path  = "$::dotcms::params::dotcms_path/dotcms_$::dotcms::params::dotcms_version"
  $server_path         = "$::dotcms::params::dotcms_distro_path/dotserver"
  $plugins_path        = "$::dotcms::params::dotcms_distro_path/plugins"
  $config_plugin_path  = "$::dotcms::params::plugins_path/com.dotcms.config"
  $tomcat_path         = "$::dotcms::params::server_path/tomcat-8.0.18"
  $application_path    = "$::dotcms::params::tomcat_path/webapps/ROOT"
  $assets_target       = "$::dotcms::params::application_path/assets"
  $assets_link         = "$::dotcms::params::application_path/assets_noused"

  $http_connector_port = '8080'

  $postgres_host       = 'localhost'
  $postgres_port       = '5432'
  $postgres_username   = 'ipsy'
  $postgres_password   = 'ipsytest'

  $java_home           = '/usr/local/java'
  $java_mem_max_size   = '2G'
  $java_mem_perm_size  = '2048m'

  $cluster             = false
  $cluster_members     = undef
  $dist_idx_enabled    = true
  $dist_idx_server_id  = undef
  $dist_idx_servers_ids  = '1,2'
  $cache_through_db    = false
  $cache_force_ipv4    = true
  $cache_protocol      = 'tcp'
  $cache_bind_port     = '7800'
  $cache_bind_address  = $::ipaddress
  $es_cluster_name     = 'dotCMSContentIndex'
  $es_network_host     = $::ipaddress
  $es_transp_tcp_port  = '9301'
  $es_network_port     = '9302'
  $es_http_enabled     = false
  $es_multicast        = false
  $es_timeout          = '5s'
  $es_unicast_hosts    = undef
  $es_replicas         = 1
  $clickstream_track   = false

  case $::osfamily {
    'Debian': {
      $extra_packages = ['libapr1-dev','libssl-dev']
      $service_name = 'dotcms'
    }
    'RedHat', 'Linux': {
      $extra_packages = ['apr-devel','openssl-devel']
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
