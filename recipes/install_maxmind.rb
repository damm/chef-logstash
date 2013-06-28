#
# Cookbook Name:: logstash
# Recipe:: install_server
#

execute "uncompress geolitecity.dat.gz" do
  cwd node['logstash']['basedir'] + "/server/lib"
  command "gunzip -d GeoLiteCity.dat.gz"
  action :nothing
  not_if { ::File.exists?("#{node['logstash']['basedir']}/server/lib/GeoLiteCity.dat") }
end

remote_file "#{node['logstash']['basedir']}/server/lib/GeoLiteCity.dat.gz" do
  source "http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz"
  action :create_if_missing
  notifies :run, "execute[uncompress geolitecity.dat.gz]"
end

