# == Class dotcms::plugin::config
#
# This class is called from dotcms for service config.
#
class dotcms::plugin::config(
  $root_plugin        = $::dotcms::root_plugin,
  $root_user          = $::dotcms::root_user,
  $root_group         = $::dotcms::root_group,
  $java_mem_max_size  = $::dotcms::java_mem_max_size,
  $java_mem_perm_size = $::dotcms::java_mem_perm_size,
  $postgres_host      = $::dotcms::postgres_host,
  $postgres_port      = $::dotcms::postgres_port,
  $postgres_username  = $::dotcms::postgres_username,
  $postgres_password  = $::dotcms::postgres_password,
  $plugin_path        = $::dotcms::plugin_path,
) {

  File {
    owner  => $root_user,
    group  => $root_group,
    ensure => directory,
  }

  file { $root_plugin : }

  file { [ "$root_plugin/dotserver/tomcat-8.0.18" , "$root_plugin/bin" ]:
    require => File[$root_plugin]
  }

  file { "$root_plugin/bin/startup.sh" :
    ensure  => present,
    content => template('dotcms/startup.sh.erb'),
    require => File["$root_plugin/bin"]
  }

  file { "$root_plugin/dotserver/tomcat-8.0.18/conf" :
    require => File["$root_plugin/dotserver/tomcat-8.0.18"]
  }

  file { "$root_plugin/dotserver/tomcat-8.0.18/conf/Catalina" :
    require => File["$root_plugin/dotserver/tomcat-8.0.18/conf"]
  }

  file { "$root_plugin/dotserver/tomcat-8.0.18/conf/Catalina/localhost" :
    require => File["$root_plugin/dotserver/tomcat-8.0.18/conf/Catalina"]
  }

  file { "$root_plugin/dotserver/tomcat-8.0.18/conf/Catalina/server.xml" :
    ensure  => present,
    content => template('dotcms/server.xml.erb'),
    require => File["$root_plugin/dotserver/tomcat-8.0.18/conf/Catalina"]
  }

  file { "$root_plugin/dotserver/tomcat-8.0.18/conf/Catalina/localhost/ROOT.xml":
    ensure  => present,
    content => template('dotcms/ROOT.xml.erb'),
    require => File["$root_plugin/dotserver/tomcat-8.0.18/conf/Catalina/localhost"]
  }

  if $cluster == true {

    if ! is_array($cluster_members) {
      fail "Expect cluster_members as an array: [host1,host2,..,hostn]"
    }
    if ! is_array($es_unicast_hosts) {
      fail "Expect internal ips with elastic search tcp port in an array: ['host1:port1','host2:port2',..,'hostn:portn']"
    }

    file {"${plugin_path}/conf/dotmarketing-config-ext.properties":
      ensure  => present,
      content => template('dotcms/dotmarketing-config-ext.properties.erb')
    }
  
  }

}
