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
  $package_name = $::dotcms::params::package_name,
  $service_name = $::dotcms::params::service_name,
  $root_plugin  = $::dotcms::params::root_plugin,
  $root_user    = $::dotcms::params::root_user,
  $root_group   = $::dotcms::params::root_group,
) inherits ::dotcms::params {

  # validate parameters here

  class { '::dotcms::install': } ->
  class { '::dotcms::plugin': } ->
  class { '::dotcms::config': } ~>
  class { '::dotcms::service': } ->
  Class['::dotcms']
}
