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

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


