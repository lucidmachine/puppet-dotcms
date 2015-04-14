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
  $package_name       = $::dotcms::params::package_name,
  $service_name       = $::dotcms::params::service_name,
  $java_home          = $::dotcms::params::java_home,
  $java_mem_max_size  = $::dotcms::params::java_mem_max_size,
  $java_mem_perm_size = $::dotcms::params::java_mem_perm_size,
  $root_plugin        = $::dotcms::params::root_plugin,
  $root_user          = $::dotcms::params::root_user,
  $root_group         = $::dotcms::params::root_group,
  $postgres_host      = $::dotcms::params::postgres_host,
  $postgres_port      = $::dotcms::params::postgres_port,
  $postgres_username  = $::dotcms::params::postgres_username,
  $postgres_password  = $::dotcms::params::postgres_password,
) inherits ::dotcms::params {

  # validate parameters here
  validate_re($postgres_host,'^.+$')

  class { '::dotcms::install': } ->
  class { '::dotcms::plugin': } ->
  class { '::dotcms::config': } ~>
  class { '::dotcms::service': } ->
  Class['::dotcms']
}
