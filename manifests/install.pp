# == Class dotcms::install
#
# This class is called from dotcms for install.
#
class dotcms::install (
    $version            = $::dotcms::version,
    $dotcms_path        = $::dotcms::dotcms_path,
    $dotcms_distro_path = $::dotcms::dotcms_distro_path,
    $service_group      = $::dotcms::service_group,
    $service_user       = $::dotcms::service_user,
    $extra_packages     = $::dotcms::extra_packages,
) {
    group { "$service_group":
        ensure => present,
    }

    user { "$service_user":
        ensure => present,
        gid => "$service_group",
        system => true,
        require => Group["$service_group"],
    }

    File {
        owner => "$service_user",
        group => "$service_group",
    }

    package { $extra_packages:
        ensure => present
    }

    file { 'dotCMS Dir':
        path => "$dotcms_path",
        ensure => 'directory',
    }

    file { 'dotCMS Distro Dir':
        path => "$dotcms_distro_path",
        ensure => 'directory',
        require => File['dotCMS Dir'],
    }

    file { 'dotCMS Distro Archive':
        path => "$dotcms_distro_path/dotcms_$version.tar.gz",
        ensure => present,
        source => "puppet:///modules/dotcms/dotcms_$version.tar.gz",
        require => File['dotCMS Distro Dir'],
    }

    exec { 'Extract Distro':
        cwd => "$dotcms_distro_path",
        command => "/bin/tar -xvzf $dotcms_distro_path/dotcms_$version.tar.gz",
        require => File['dotCMS Distro Archive'],
    }

    exec { 'Make dotCMS Scripts Executable':
        cwd => "$dotcms_distro_path",
        command => "/bin/chmod 755 $dotcms_distro_path/bin/*.sh",
        require => Exec['Extract Distro'],
    }

    exec { 'Make Tomcat Scripts Executable':
        cwd => "$dotcms_distro_path",
        command => "/bin/chmod 755 $tomcat_path/bin/*.sh",
        require => Exec['Extract Distro'],
    }
}
