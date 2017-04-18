# == Class dotcms::plugin::config
#
# This class is called from dotcms for service config.
#
class dotcms::plugin::config(
  $plugins_path       = $::dotcms::plugins_path,
  $config_plugin_path = $::dotcms::config_plugin_path,

  $root_user          = $::dotcms::root_user,
  $root_group         = $::dotcms::root_group,

  $java_mem_max_size  = $::dotcms::java_mem_max_size,
  $java_mem_perm_size = $::dotcms::java_mem_perm_size,

  $postgres_host      = $::dotcms::postgres_host,
  $postgres_port      = $::dotcms::postgres_port,
  $postgres_username  = $::dotcms::postgres_username,
  $postgres_password  = $::dotcms::postgres_password,
) {

  File {
    ensure => directory,
  }

  file { "$plugins_path": }

  file { "$config_plugin_path":
    require => File["$plugins_path"],
  }

  file { "$config_plugin_path/ROOT":
    require => File["$config_plugin_path"],
  }

  file { "$config_plugin_path/ROOT/bin":
    require => File["$config_plugin_path/ROOT"],
  }

  file { "$config_plugin_path/ROOT/bin/startup.sh":
    ensure  => present,
    content => template('dotcms/startup.sh.erb'),
    require => File["$config_plugin_path/ROOT/bin/"],
  }

  file { "$config_plugin_path/ROOT/dotserver":
    require => File["$config_plugin_path/ROOT"],
  }

  file { "$config_plugin_path/ROOT/dotserver/tomcat-8.0.18":
    require => File["$config_plugin_path/ROOT/dotserver"],
  }

  file { "$config_plugin_path/ROOT/dotserver/tomcat-8.0.18/conf" :
    require => File["$config_plugin_path/ROOT/dotserver/tomcat-8.0.18"]
  }

  file { "$config_plugin_path/ROOT/dotserver/tomcat-8.0.18/conf/Catalina" :
    require => File["$config_plugin_path/ROOT/dotserver/tomcat-8.0.18/conf"]
  }

  file { "$config_plugin_path/ROOT/dotserver/tomcat-8.0.18/conf/Catalina/server.xml" :
    ensure  => present,
    content => template('dotcms/server.xml.erb'),
    require => File["$config_plugin_path/ROOT/dotserver/tomcat-8.0.18/conf/Catalina"]
  }


  file { "$config_plugin_path/ROOT/dotserver/tomcat-8.0.18/conf/Catalina/localhost" :
    require => File["$config_plugin_path/ROOT/dotserver/tomcat-8.0.18/conf/Catalina"]
  }

  file { "$config_plugin_path/ROOT/dotserver/tomcat-8.0.18/conf/Catalina/localhost/ROOT.xml":
    ensure  => present,
    content => template('dotcms/ROOT.xml.erb'),
    require => File["$config_plugin_path/ROOT/dotserver/tomcat-8.0.18/conf/Catalina/localhost"]
  }
  
}
