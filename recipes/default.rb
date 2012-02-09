#
# Cookbook Name:: azkaban
# Recipe:: default
#

# Add azkaban user and group

group "#{node[:azkaban][:group]}" 

user "#{node[:azkaban][:user]}" do
  comment "Azkaban Job scheduler"
  system true
  gid "#{node[:azkaban][:group]}"
  shell "/bin/false"
end

# Create directories for install and jobs
%w( job_dir deploy_to ).each do |key|
  directory node[:azkaban][key.to_sym] do
    mode 0750
    owner "#{node[:azkaban][:user]}"
    group "#{node[:azkaban][:group]}"
    action :create
    recursive true
  end
end

# Get the tar
remote_file "/tmp/azkaban.tar.gz" do
  source "#{node[:azkaban][:source_tar]}"
  not_if {File.exists?("#{node[:azkaban][:deploy_to]}/bin")}
  notifies :run, "execute[explode azkaban]", :immediately
end

# Explode/install the tar
execute "explode azkaban" do
  command "tar -xzf /tmp/azkaban.tar.gz -C #{node[:azkaban][:deploy_to]} --strip=1"
  action :nothing
end
