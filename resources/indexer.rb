# 
# Cookbook Name:: logstash
# Resource:: logstash::indexer

# Copyright 2013, MoPub
# Author:: Scott M. Likens (<scott@mopub.com>)


# Create an logstash indexer
actions :create

# Base directory where logstash is to be installed
attribute :basedir, :kind_of => String, :default => "/opt/logstash"
# User that logstash runs as
attribute :user, :kind_of => String, :default => "logstash"
# Group that logstash runs under
attribute :group, :kind_of => String, :default => "logstash"
# Where logstash should output it's server output 
attribute :log_dir, :kind_of => String, :default => "/var/log/logstash"
# Where logstash should store it's pid
attribute :pid_dir, :kind_of => String, :default => "/var/run/logstash"
# Relative path to store the pattern files 
attribute :patterns_dir, :kind_of => String, :default => "server/etc/patterns"
# Determines what erb template is used to generate the logstash configuration
attribute :base_config, :kind_of => String, :default => "server.conf.erb"
# Determines where the erb template can be found
attribute :base_config_cookbook, :kind_of => String, :default => "logstash"
# Minimum memory to assign to the JVM
attribute :xms, :kind_of => String, :default => "1024M"
# Maximum memory to assign to the JVM
attribute :xmx, :kind_of => String, :default => "1024M"
# Additional options to pass to the JVM
attribute :java_opts, :kind_of => String, :default => String.new
# Default Gargbage Collection Options
attribute :gc_opts, :kind_of => String, :default => "-XX:+UseParallelOldGC"
# Enable ipv4 only stack? 
attribute :ipv4_only, :kind_of => [TrueClass, FalseClass], :default => false
# Logstash filters see http://logstash.net/docs/1.1.13/ for more information on filters plugin
attribute :filters, :kind_of => Array, :default => []
# Logstash inputs see http://logstash.net/docs/1.1.13/ for more information on inputs plugin
attribute :inputs, :kind_of => Array, :default => []
# Logstash patterns see http://logstash.net/docs/1.1.13/ for more information on patterns plugin
attribute :patterns, :kind_of => Array, :default => []
# Logstash output see http://logstash.net/docs/1.1.13/ for more information on the output plugin
attribute :output, :kind_of => Array, :default => []

def initialize(*args)
  super
# By default we don't want to run our provider unless called upon
  @action = :nothing
# We need to install the logstash server, logrotate and runit.
  @run_context.include_recipe ["logstash::install_server", "logrotate","runit::default"]
end

