# == Class dotcms::service
#
# This class is meant to be called from dotcms.
# It ensure the service is running.
#
class dotcms::service {

    File {
        owner => "$::dotcms::root_user",
        group => "$::dotcms::root_group",
    }

    case $::osfamily {

        default: {
            # Service script
            file { "/etc/init.d/$::dotcms::service_name":
                ensure => present,
                mode => 0755,
                content => template('dotcms/service_initd.erb'),
            }

            # Sys V Runlevel 3 Link
            file { "/etc/rc3.d/S03$::dotcms::service_name":
                ensure => 'link',
                target => "/etc/init.d/$::dotcms::service_name",
                require => File["/etc/init.d/$::dotcms::service_name"],
            }

            service { $::dotcms::service_name:
                ensure     => running,
                hasstatus  => false,
                hasrestart => true,
                provider   => init,
                require    => [
                    File["/etc/init.d/$::dotcms::service_name"],
                    File["/etc/rc3.d/S03$::dotcms::service_name"],
                ]
            }
        }
    }

}
