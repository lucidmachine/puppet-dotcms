# == Class dotcms::config
#
# This class is called from dotcms for service config.
#
class dotcms::config(
  $root_plugin       = $::dotcms::root_plugin,
  $root_user         = $::dotcms::root_user,
  $root_group        = $::dotcms::root_group,
  $postgres_url      = $::dotcms::postgres_url,
  $postgres_username = $::dotcms::postgres_username,
  $postgres_password = $::dotcms::postgres_password,
) {

}
