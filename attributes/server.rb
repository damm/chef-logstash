#
# Cookbook Name:: logstash
# Attribute:: install_server

# The version of logstash to install
default['logstash']['server']['version'] = '1.1.13'
# The url to fetch logstash from
default['logstash']['server']['source_url'] = 'https://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar'
# sha256sum of the logstash jar
default['logstash']['server']['checksum'] = '5ba0639ff4da064c2a4f6a04bd7006b1997a6573859d3691e210b6855e1e47f1'
# What installation method to use? jar is default
default['logstash']['server']['install_method'] = 'jar' # Either `source` or `jar`
default['logstash']['server']['patterns_dir'] = 'server/etc/patterns'
default['logstash']['server']['base_config'] = 'server.conf.erb'
default['logstash']['server']['base_config_cookbook'] = 'logstash'
default['logstash']['server']['xms'] = '1024M'
default['logstash']['server']['xmx'] = '1024M'
default['logstash']['server']['java_opts'] = ''
default['logstash']['server']['gc_opts'] = '-XX:+UseParallelOldGC'
default['logstash']['server']['ipv4_only'] = false
default['logstash']['server']['debug'] = false
default['logstash']['server']['home'] = '/opt/logstash/server'
default['logstash']['server']['install_rabbitmq'] = true

# roles/flags for various autoconfig/discovery components
default['logstash']['server']['enable_embedded_es'] = false

default['logstash']['server']['inputs'] = []
default['logstash']['server']['filters'] = []
default['logstash']['server']['outputs'] = []

  
