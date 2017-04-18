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

##### dotcms_version

##### service_name
##### service_user
##### service_group
##### service_path
##### service_pid_path

##### root_user
##### root_group

##### http_connector_port

##### dotcms_pid_path
##### dotcms_path
##### dotcms_distro_path
##### server_path
##### plugins_path
##### config_plugin_path
##### tomcat_path
##### application_path
##### assets_target
##### assets_link

##### postgres_host
##### postgres_port
##### postgres_username
##### postgres_password

##### java_home
##### java_mem_max_size
##### java_mem_perm_size

##### cluster
##### cluster_members
##### dist_idx_enabled
##### dist_idx_server_id
##### dist_idx_servers_ids
##### cache_through_db
##### cache_force_ipv4
##### cache_protocol
##### cache_bind_port
##### cache_bind_address
##### es_cluster_name
##### es_network_host
##### es_transp_tcp_port
##### es_network_port
##### es_http_enabled
##### es_multicast
##### es_timeout
##### es_unicast_hosts
##### es_replicas
##### clickstream_track

## Limitations

* OS
    * This module is currently only tested on Ubuntu 16.04.
    * This module currently only supports System V init.d services.
* DB - This module currently only configures dotCMS to work with the PostgreSQL database server. dotCMS also supports H2 and MySQL in the dotCMS Community Edition and Microsoft SQL Server and Oracle in dotCMS Enterprise Edition.
* dotCMS - This module only controls the open-source dotCMS Community Edition. There is no support for dotCMS Enterprise Edition.
* Puppet - This module is only tested using Puppet 3.8.5.

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Contributors
View the full list of contributors in [the CONTRIBUTORS file]().
