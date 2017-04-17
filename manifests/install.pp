# == Class dotcms::install
#
# This class is called from dotcms for install.
#
class dotcms::install {

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
        path => "$::dotcms::params::dotcms_distro_path/dotcms_$::dotcms::params::dotcms_version.tar.gz",
        ensure => present,
        source => "puppet:///modules/dotcms/dotcms_$::dotcms::params::dotcms_version.tar.gz",
        require => File['dotCMS Distro Dir'],
    }

    exec { 'Extract Distro':
        cwd => "$::dotcms::params::dotcms_distro_path",
        command => "/bin/tar -xvzf $::dotcms::params::dotcms_distro_path/dotcms_$::dotcms::params::dotcms_version.tar.gz",
        require => File['dotCMS Distro Archive'],
    }

    exec { 'Make Scripts Executable':
        cwd => "$::dotcms::params::dotcms_distro_path",
        command => "/bin/chmod 755 $::dotcms::params::dotcms_distro_path/bin/*.sh",
        require => Exec['Extract Distro'],
    }
}
