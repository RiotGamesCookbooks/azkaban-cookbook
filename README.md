# Azkaban cookbook

Installs and configures [Azkaban](https://github.com/azkaban/azkaban)
---
Requirements
============

* tar

Platform
--------

* CentOS, Red Hat, Fedora

Cookbooks
---------

* java

---
Attributes
==========

* `node["java"]["install_flavor"]` - Flavor of JVM you would like installed (`oracle` or `openjdk`), default `oracle`.
* `node['java']['java_home']`
* `node['java']['tarball']` - name of the tarball to retrieve from your corporate repository default `jdk1.6.0_29_i386.tar.gz`
* `node['java']['tarball_checksum']` - checksum for the tarball, if you use a different tarball, you also need to create a new sha256 checksum

default[:azkaban][:user] = "azkaban"
default[:azkaban][:group] = "azkaban"

Provide version, default is latest. Master is currently not supported. A list of avaliable versions can be found [here](https://github.com/azkaban/azkaban/downloads).
 
default[:azkaban][:version] = "0.10"
default[:azkaban][:deploy_to] = "/srv"
default[:azkaban][:job_dir] = "#{node[:azkaban][:deploy_to]}/azkaban-jobs"

If you have a source youd rather use provide the url below. File name is expected to be azkaban-[:version].tar.gz

default[:azkaban][:repo_url] = "https://github.com/downloads/azkaban/azkaban"
---

# License and Author

Author:: Cliff Erson (<cerson@me.com>)
Author:: Jamie Winsor (<jamie@vialstudios.com>)

Copyright 2012, Riot Games

See LICENSE for license details
