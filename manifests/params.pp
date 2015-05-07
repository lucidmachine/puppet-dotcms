# == Class dotcms::params
#
# This class is meant to be called from dotcms.
# It sets variables according to platform.
#
class dotcms::params {

  $plugin_path         = '/opt/dotcms/dotserver/plugins/com.dotcms.config'
  $root_plugin         = '/opt/dotcms/dotserver/plugins/com.dotcms.config/ROOT'
  $postgres_host       = 'localhost'
  $postgres_port       = '5432'
  $postgres_username   = 'ipsy'
  $postgres_password   = 'ipsytest'
  $java_home           = '/usr/local/java'
  $server_path         = '/opt/dotcms/dotserver'
  $java_mem_max_size   = '2G'
  $java_mem_perm_size  = '2048m'
  $assets_target       = '/opt/dotcms/dotserver/dotCMS/assets'
  $assets_link         = '/opt/dotcms/dotserver/dotCMS/assets_noused'
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
      $extra_packages = ['libapr1.0-dev','libssl-dev']
      $package_name = 'dotcms'
      $service_name = 'dotcms'
    }
    'RedHat', 'Linux': {
      $extra_packages = ['apr-devel','openssl-devel']
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
