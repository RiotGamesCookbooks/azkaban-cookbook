#
# Cookbook Name:: azkaban
# Recipe:: default
#
# Author:: Cliff Erson (<cerson@me.com>)
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
# Copyright 2012, Riot Games
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

group node[:azkaban][:group]

user node[:azkaban][:user] do
  comment "Azkaban Job scheduler"
  system true
  gid node[:azkaban][:group]
  shell "/bin/false"
end

directory node[:azkaban][:deploy_to]

azkaban_tar = "#{Chef::Config[:file_cache_path]}/azkaban-#{node[:azkaban][:version]}.tar.gz"

log "Downloading Azkaban... "

remote_file azkaban_tar do
  source "#{node[:azkaban][:repo_url]}/azkaban-#{node[:azkaban][:version]}.tar.gz"
  action :create_if_missing
end

execute "extract_azkaban" do
  command "tar -xzf #{azkaban_tar} -C #{node[:azkaban][:deploy_to]}"
  action :run
  not_if { File.exists?("#{node[:azkaban][:deploy_to]}/azkaban-#{node[:azkaban][:version]}") }
end

directory node[:azkaban][:job_dir] do
  mode 0750
  owner node[:azkaban][:user]
  group node[:azkaban][:group]
  action :create
  recursive true
end

directory "#{node[:azkaban][:deploy_to]}/azkaban-#{node[:azkaban][:version]}" do
  mode 0750
  owner node[:azkaban][:user]
  group node[:azkaban][:group]
  action :create
  recursive true
end

link "#{node[:azkaban][:deploy_to]}/azkaban" do
  to "#{node[:azkaban][:deploy_to]}/azkaban-#{node[:azkaban][:version]}"
  owner node[:azkaban][:user]
  group node[:azkaban][:group]
end

template "/etc/profile.d/azkaban.sh" do
  mode 0644
  owner "root"
  group "root"
  action :create_if_missing
end
