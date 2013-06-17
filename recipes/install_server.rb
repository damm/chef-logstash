#
# Cookbook Name:: logstash
# Recipe:: install_server
#

# Logstash depends on java being installed.
include_recipe "java"

# Do we need to create a logstash account? if so create it.
if node['logstash']['create_account']

  group node['logstash']['group'] do
    system true
  end

  user node['logstash']['user'] do
    group node['logstash']['group']
    home "/var/lib/logstash"
    system true
    action :create
    manage_home true
  end

end

node['logstash']['join_groups'].each do |grp|
  group grp do
    members node['logstash']['user']
    action :modify
    append true
    only_if "grep -q '^#{grp}:' /etc/group"
  end
end

directory node['logstash']['basedir'] do
  action :create
  owner "root"
  group "root"
  mode "0755"
end

directory node['logstash']['log_dir'] do
  action :create
  mode "0755"
  owner node['logstash']['user']
  group node['logstash']['group']
  recursive true
end

logrotate_app "logstash_server" do
  path "#{node['logstash']['log_dir']}/*.log"
  frequency "daily"
  rotate "30"
  options [ "missingok", "notifempty" ]
  create "664 #{node['logstash']['user']} #{node['logstash']['group']}"
end

# Create directory for logstash
directory "#{node['logstash']['basedir']}/server" do
  action :create
  mode "0755"
  owner node['logstash']['user']
  group node['logstash']['group']
end

# Let's make sure all the directory's are created before hand.
%w{bin etc lib log tmp }.each do |ldir|
  directory "#{node['logstash']['basedir']}/server/#{ldir}" do
    action :create
    mode "0755"
    owner node['logstash']['user']
    group node['logstash']['group']
  end
end

# installation
if node['logstash']['server']['install_method'] == "jar"
  remote_file "#{node['logstash']['basedir']}/server/lib/logstash-#{node['logstash']['server']['version']}.jar" do
    owner "root"
    group "root"
    mode "0755"
    source node['logstash']['server']['source_url']
    checksum node['logstash']['server']['checksum']
    action :create_if_missing
  end

  link "#{node['logstash']['basedir']}/server/lib/logstash.jar" do
    to "#{node['logstash']['basedir']}/server/lib/logstash-#{node['logstash']['server']['version']}.jar"
  end
else
  include_recipe "logstash::source"

  logstash_version = node['logstash']['source']['sha'] || "v#{node['logstash']['server']['version']}"
  link "#{node['logstash']['basedir']}/server/lib/logstash.jar" do
    to "#{node['logstash']['basedir']}/source/build/logstash-#{logstash_version}-monolithic.jar"
  end
end

directory "#{node['logstash']['basedir']}/server/etc/conf.d" do
  action :create
  mode "0755"
  owner node['logstash']['user']
  group node['logstash']['group']
end
