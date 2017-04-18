# == Class dotcms::install
#
# This class is called from dotcms for install.
#
class dotcms::install {
    group { "$::dotcms::service_group":
        ensure => present,
    }

    user { "$::dotcms::service_user":
        ensure => present,
        gid => "$::dotcms::service_group",
        system => true,
        require => Group["$::dotcms::service_group"],
    }

    File {
        owner => "$::dotcms::params::service_user",
        group => "$::dotcms::params::service_group",
    }

    package { $::dotcms::extra_packages:
        ensure => present
    }

    file { 'dotCMS Dir':
        path => "$::dotcms::params::dotcms_path",
        ensure => 'directory',
    }

    file { 'dotCMS Distro Dir':
        path => "$::dotcms::params::dotcms_distro_path",
        ensure => 'directory',
        require => File['dotCMS Dir'],
    }

    file { 'dotCMS Distro Archive':
        path => "$::dotcms::params::dotcms_distro_path/dotcms_$::dotcms::params::version.tar.gz",
        ensure => present,
        source => "puppet:///modules/dotcms/dotcms_$::dotcms::params::version.tar.gz",
        require => File['dotCMS Distro Dir'],
    }

    exec { 'Extract Distro':
        cwd => "$::dotcms::params::dotcms_distro_path",
        command => "/bin/tar -xvzf $::dotcms::params::dotcms_distro_path/dotcms_$::dotcms::params::version.tar.gz",
        require => File['dotCMS Distro Archive'],
    }

    exec { 'Make dotCMS Scripts Executable':
        cwd => "$::dotcms::params::dotcms_distro_path",
        command => "/bin/chmod 755 $::dotcms::params::dotcms_distro_path/bin/*.sh",
        require => Exec['Extract Distro'],
    }

    exec { 'Make Tomcat Scripts Executable':
        cwd => "$::dotcms::params::dotcms_distro_path",
        command => "/bin/chmod 755 $::dotcms::tomcat_path/bin/*.sh",
        require => Exec['Extract Distro'],
    }
}
