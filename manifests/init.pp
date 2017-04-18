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
  $extra_packages       = $::dotcms::params::extra_packages,
  $version              = $::dotcms::params::version,

  $service_name         = $::dotcms::params::service_name,
  $service_user         = $::dotcms::params::service_user,
  $service_group        = $::dotcms::params::service_group,
  $service_path         = $::dotcms::params::service_path,
  $service_pid_path     = $::dotcms::params::service_pid_path,
  
  $root_user            = $::dotcms::params::root_user,
  $root_group           = $::dotcms::params::root_group,

  $http_connector_port  = $::dotcms::params::http_connector_port,

  $dotcms_pid_path      = $::dotcms::params::dotcms_pid_path,
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

) inherits ::dotcms::params {

  # validate parameters here
  validate_re($postgres_host,'^.+$','The postgres host variable passed is not valid!')

  class { '::dotcms::install': } ->
  class { '::dotcms::config': } ~>
  class { '::dotcms::reindex': } ->
  class { '::dotcms::plugin': } ->
  class { '::dotcms::service': } ->
  Class['::dotcms']
}
