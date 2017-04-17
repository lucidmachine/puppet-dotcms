# == Class: dotcms
#
# Full description of class dotcms here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class dotcms (
  $dotcms_version       = $::dotcms::params::dotcms_version,

  $package_name         = $::dotcms::params::package_name,
  $service_name         = $::dotcms::params::service_name,
  $root_user            = $::dotcms::params::root_user,
  $root_group           = $::dotcms::params::root_group,

  $http_connector_port  = $::dotcms::params::http_connector_port,

  $dotcms_path          = $::dotcms::params::dotcms_path,
  $dotcms_distro_path   = $::dotcms::params::dotcms_distro_path,
  $server_path          = $::dotcms::params::server_path,
  $plugins_path         = $::dotcms::params::plugins_path,
  $config_plugin_path   = $::dotcms::params::config_plugin_path,
  $tomcat_path          = $::dotcms::params::tomcat_path,
  $application_path     = $::dotcms::params::application_path,
  $assets_target        = $::dotcms::params::assets_target,
  $assets_link          = $::dotcms::params::assets_link,

  $postgres_host        = $::dotcms::params::postgres_host,
  $postgres_port        = $::dotcms::params::postgres_port,
  $postgres_username    = $::dotcms::params::postgres_username,
  $postgres_password    = $::dotcms::params::postgres_password,

  $java_home            = $::dotcms::params::java_home,
  $java_mem_max_size    = $::dotcms::params::java_mem_max_size,
  $java_mem_perm_size   = $::dotcms::params::java_mem_perm_size,

  $cluster              = $::dotcms::params::cluster,
  $cluster_members      = $::dotcms::params::cluster_members,
  $dist_idx_enabled     = $::dotcms::params::dist_idx_enabled,
  $dist_idx_server_id   = $::dotcms::params::dist_idx_server_id,
  $dist_idx_servers_ids = $::dotcms::params::dist_idx_servers_ids,
  $cache_through_db     = $::dotcms::params::cache_through_db,
  $cache_force_ipv4     = $::dotcms::params::cache_force_ipv4,
  $cache_protocol       = $::dotcms::params::cache_protocol,
  $cache_bind_port      = $::dotcms::params::cache_bind_port,
  $cache_bind_address   = $::dotcms::params::cache_bind_address,
  $es_cluster_name      = $::dotcms::params::es_cluster_name,
  $es_network_host      = $::dotcms::params::es_network_host,
  $es_transp_tcp_port   = $::dotcms::params::es_transp_tcp_port,
  $es_network_port      = $::dotcms::params::es_network_port,
  $es_http_enabled      = $::dotcms::params::es_http_enabled,
  $es_multicast         = $::dotcms::params::es_multicast,
  $es_timeout           = $::dotcms::params::es_timeout,
  $es_unicast_hosts     = $::dotcms::params::es_unicast_hosts,
  $es_replicas          = $::dotcms::params::es_replicas,
  $clickstream_track    = $::dotcms::params::clickstream_track,
) inherits ::dotcms::params {

  # validate parameters here
  validate_re($postgres_host,'^.+$','The postgres host variable passed is not valid!')

  class { '::dotcms::install': } ->
  class { '::dotcms::config': } ~>
  class { '::dotcms::reindex': } ->
  class { '::dotcms::restart': } ->
  class { '::dotcms::plugin': } ->
  # We would like to create a service in the future instead of a restart class:
  # class { '::dotcms::service': } ->
  Class['::dotcms']
}
