#
# Cookbook Name:: logstash

# Git repo to fetch logstash from
default['logstash']['source']['repo'] = 'git://github.com/logstash/logstash.git'
# What sha to use
default['logstash']['source']['sha'] = nil
# Where the jdk path is
default['logstash']['source']['java_home'] = '/usr/lib/jvm/java-6-openjdk/' # openjdk6 on ubuntu
