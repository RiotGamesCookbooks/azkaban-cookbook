#
# Cookbook Name:: azkaban
# Recipe:: default
#
# Author:: Cliff Erson (<cdickerson@riotgames.com>)
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

group "#{node[:azkaban][:group]}" 

user "#{node[:azkaban][:user]}" do
  comment "Azkaban Job scheduler"
  system true
  gid "#{node[:azkaban][:group]}"
  shell "/bin/false"
end

%w( job_dir deploy_to ).each do |key|
  directory node[:azkaban][key.to_sym] do
    mode 0750
    owner "#{node[:azkaban][:user]}"
    group "#{node[:azkaban][:group]}"
    action :create
    recursive true
  end
end

remote_file "/tmp/azkaban.tar.gz" do
  source "#{node[:azkaban][:source_tar]}"
  not_if {File.exists?("#{node[:azkaban][:deploy_to]}/bin")}
  notifies :run, "execute[explode azkaban]", :immediately
end

execute "explode azkaban" do
  command "tar -xzf /tmp/azkaban.tar.gz -C #{node[:azkaban][:deploy_to]} --strip=1"
  action :nothing
end
