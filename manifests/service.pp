# == Class dotcms::service
#
# This class is meant to be called from dotcms.
# It ensure the service is running.
#
class dotcms::service (
  $root_user          = $::dotcms::root_user,
  $root_group         = $::dotcms::root_group,
  $java_home          = $::dotcms::java_home,
  $dotcms_distro_path = $::dotcms::dotcms_distro_path,
  $service_name       = $::dotcms::service_name,
  $service_pid_path   = $::dotcms::service_pid_path,
) {

  File {
    owner => "$root_user",
    group => "$root_group",
  }

  case $::osfamily {

    default: {
      # Service script
      file { "/etc/init.d/$service_name":
        ensure => present,
        mode => 0755,
        content => template('dotcms/service_initd.erb'),
      }

      # Sys V Runlevel 3 Link
      file { "/etc/rc3.d/S03$service_name":
        ensure => 'link',
        target => "/etc/init.d/$service_name",
        require => File["/etc/init.d/$service_name"],
      }

      service { $service_name:
        ensure     => running,
        hasstatus  => false,
        hasrestart => true,
        provider   => init,
        require    => [
          File["/etc/init.d/$service_name"],
          File["/etc/rc3.d/S03$service_name"],
        ]
      }
    }
  }

}
