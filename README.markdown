#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with dotcms](#setup)
    * [What dotcms affects](#what-dotcms-affects)
    * [Beginning with dotcms](#beginning-with-dotcms)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

The dotcms module installs and manages [dotCMS](https://dotcms.com/) with Puppet.

[dotCMS](https://dotcms.com/) is a scalable, Java-based, open source content management system (CMS) that has been designed to manage and deliver personalized, permission based content experiences across multiple channels. dotCMS can serve as the plaform for sites, mobile apps, mini-sites, portals, intranets or as a headless CMS (content is consumed via RESTful APIs).

## Setup

### What dotcms affects

* dotCMS application and bundled server installation.
    * Installs application to /opt/dotcms/dotcms_x.y.z/ by default.
    * Uses dotCMS' release directory structure by default.
    * Uses the dotCMS release's bundled Tomcat instance by default.
* Manages the general application configuration plugin in /opt/dotcms/dotcms_x.y.z/plugins/com.dotcms.config/. For configuration plugin information, see [dotCMS' documentation on Changing dotCMS Configuration Properties](https://dotcms.com/docs/latest/changing-dotcms-configuration-properties).
    * Configures Tomcat HTTP connector for port 8080 by default.
* dotCMS system services.

### Beginning with dotcms

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps for upgrading, you may wish to include an additional section here: Upgrading (For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

### Install and Configure the Application
In order to install and configure the application, declare the dotcms class.

```puppet
class { 'dotcms': }
```

It is recommended that you set, at a minimum, your PostgreSQL database information parameters.

```puppet
class { 'dotcms':
    postgres_username => 'my_dotcms_db_user',
    postgres_password => 'my_extremely_secure_dotcms_db_password',
}
```

For more configuration options, see the [Reference section](#reference).

## Reference

**Classes:**
* [dotcms](#dotcms)

### Classes

#### dotcms

Installs and configures the dotCMS application and service.

##### `version`
The version number of the dotCMS release to install. Default is '3.7.1'.

##### `service_name`
The name of the dotCMS service used to manage the dotCMS application. Default is 'dotcms'.

##### `service_user`
The name of the user used to control the dotCMS application. Default is 'dotcms'.

##### `service_group`
The name of the group used to control the dotCMS application. Default is 'dotcms'.

##### `service_path`
Run directory for the dotCMS service. Default is '/var/run/dotcms'.

##### `service_pid_path`
Path to the dotCMS service's PID file. Default is "$::dotcms::params::service_path/dotcms.pid" (e.g. "/var/run/dotcms/dotcms.pid").

##### `root_user`
Name of the system root user. Default is 'root'.

##### `root_group`
Name of the system root group. Default is 'root'.


##### `http_connector_port`
The number of the port to which dotCMS' HTTP connector will be connected. Default is '8080'.

##### `dotcms_pid_path`
The path to the PID file which the dotCMS application uses to track the Java process which runs dotCMS on the bundled Tomcat server. Default is '/tmp/dotcms.pid'.

##### `dotcms_path`
The path to the dotCMS parent directory. This directory may contain multiple directories which contain versioned dotCMS releases. For example:

```
$ tree dotcms
dotcms
├── dotcms_3.7.1
└── dotcms_4.0.1
```
Default is '/opt/dotcms'.

##### `dotcms_distro_path`
The path to the versioned dotCMS release under management. This directory is expected to be a subdirectory of [dotcms_path](#dotcms_path). Default is "$::dotcms::params::dotcms_path/dotcms_$::dotcms::params::version" (e.g. "/opt/dotcms/dotcms_3.7.1").

##### `server_path`
The path to the dotserver directory of the dotCMS release under management. This directory is expected to be a subdirectory of [dotcms_distro_path](#dotcms_distro_path). Default is "$::dotcms::params::dotcms_distro_path/dotserver" (e.g. "/opt/dotcms/dotcms_3.7.1/dotserver").

##### `plugins_path`
The path to the plugins directory of the dotCMS release under management. This directory is expected to be a subdirectory of [dotcms_distro_path](#dotcms_distro_path). Default is "$::dotcms::params::dotcms_distro_path/plugins" (e.g. "/opt/dotcms/dotcms_3.7.1/plugins").

##### `config_plugin_path`
The path to the main configuration plugin of the dotCMS release under management. This directory is expected to be a subdirectory of [plugins_path](#plugins_path). Default is "$::dotcms::params::plugins_path/com.dotcms.config" (e.g. "/opt/dotcms/dotcms_3.7.1/plugins/com.dotcms.config").

##### `tomcat_path`
The path to the bundled Tomcat distribution's directory in the dotCMS release under management. This directory is expected to be a subdirectory of [server_path](#server_path). Default is "$::dotcms::params::server_path/tomcat-8.0.18" (e.g. "/opt/dotcms/dotcms_3.7.1/dotserver/tomcat-8.0.18").

##### `application_path`
The path to the exploded dotCMS web application. This directory is expected to be a child of [tomcat_path](#tomcat_path). Default is "$::dotcms::params::tomcat_path/webapps/ROOT" (e.g. "/opt/dotcms/dotcms_3.7.1/dotserver/tomcat-8.0.18/webapps/ROOT").

##### `assets_target`
The path to the assets directory of the dotCMS release under management. This directory is expected to be a child of [application_path](#application_path). Default is "$::dotcms::params::application_path/assets" (e.g. "/opt/dotcms/dotcms_3.7.1/dotserver/tomcat-8.0.18/webapps/ROOT/assets").

##### `assets_link`
The target path for a symlink to [assets_target](#assets_target). Default is "$::dotcms::params::application_path/assets_noused" (e.g. "/opt/dotcms/dotcms_3.7.1/dotserver/tomcat-8.0.18/webapps/ROOT/assets_noused").

##### `postgres_host`
The host of the PostgreSQL database to which dotCMS connects. Default is 'localhost'.

##### `postgres_port`
The port through which dotCMS connects to its PostgreSQL database. Default is '5432'.

##### `postgres_username`
The username which dotCMS uses to authenticate its connection to the PostgreSQL database. Required.

##### `postgres_password`
The password which dotCMS uses to authenticate its connection to the PostgreSQL database. Required.

##### `java_home`
The path to the Java distribution directory. Default is '/usr/local/java'.

##### `java_mem_max_size`
The maximum heap size which the JVM running dotCMS may allocate. This is the value passed to the java flag '-Xmx'. See the [java documentation](https://docs.oracle.com/javase/8/docs/technotes/tools/windows/java.html#BABDJJFI) for more information. Default is '2G'.

##### `java_mem_perm_size`
The maximum permanent generation space size which the JVM running dotCMS may allocate. This is the value passed to the java flag '-XX:MaxPermSize'. See the [java documentation](https://docs.oracle.com/javase/8/docs/technotes/tools/windows/java.html#BABDJJFI) for more information. Default is '2048m'.


## Limitations

* OS
    * This module is currently only tested on Ubuntu 16.04.
    * This module currently only supports System V init.d services.
* DB - This module currently only configures dotCMS to work with the PostgreSQL database server. dotCMS also supports H2 and MySQL in the dotCMS Community Edition and Microsoft SQL Server and Oracle in dotCMS Enterprise Edition.
* dotCMS - This module only controls the open-source dotCMS Community Edition. There is no support for dotCMS Enterprise Edition.
    * Enterprise features including clustering and push publishing cannot be configured via this module.
* Puppet - This module is only tested using Puppet 3.8.5.

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Contributors
View the full list of contributors in [the CONTRIBUTORS file]().
