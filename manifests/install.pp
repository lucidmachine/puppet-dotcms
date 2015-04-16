# == Class dotcms::install
#
# This class is called from dotcms for install.
#
class dotcms::install {

  package { $::dotcms::extra_packages: ensure => present }

  #  package { $::dotcms::package_name:
  #  ensure => present,
  #}
}
