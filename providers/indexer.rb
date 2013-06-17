#
# Cookbook Name:: logstash
# Provider:: logstash::indexer

# Copyright 2013, MoPub
# Author:: Scott M. Likens (<scott@mopub.com>)

use_inline_resources

# Creates a logstash indexer
action :create do
  # `patterns_dir` is a relative path; we have to append the basedir to the front of the string.
  patterns_dir = new_resource.basedir + "/" + new_resource.patterns_dir
  
  # Ensure the `patterns_dir` exists
  directory patterns_dir do
    action :create
    mode "0755"
    owner new_resource.user
    group new_resource.group
  end
  # Each indexer has it's own temporary directory
  directory new_resource.basedir + "/server/tmp/" + new_resource.name do
    action :create
    mode 0755
    owner new_resource.user
    group new_resource.group
  end
  
  # Write all the `patterns` to disk
  new_resource.patterns.each do |output|
    output.sort.each do |name,hash|
      template_name = patterns_dir + '/' + name.to_s
      template template_name do
        source 'patterns.erb'
        cookbook new_resource.base_config_cookbook
        owner new_resource.user
        group new_resource.group
        variables(:patterns => hash)
        mode '0644'
        notifies :restart, "runit_service[#{new_resource.name}]"
      end
    end
  end
  
  # Generate the Logstash Configuration file for the Indexer
  template "#{new_resource.basedir}/server/etc/#{new_resource.name}.conf" do
    source new_resource.base_config
    cookbook new_resource.base_config_cookbook
    owner new_resource.user
    group new_resource.group
    mode "0644"
    variables({
                :name => new_resource.name,
                :filters => new_resource.filters,
                :inputs => new_resource.inputs,
                :output => new_resource.output,
                :patterns_dir => patterns_dir})
    notifies :restart, "runit_service[#{new_resource.name}]"
    action :create
  end
  
  # Start the indexer under runit
  runit_service new_resource.name do
    default_logger true
    run_template_name "logstash_server"
    cookbook new_resource.base_config_cookbook
    options({
              :name => new_resource.name,
              :max_heap => node['logstash']['server']['xmx'],
              :min_heap => node['logstash']['server']['xms']
            })
  end
end
