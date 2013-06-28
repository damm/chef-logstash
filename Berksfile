metadata

cookbook 'logrotate'
cookbook 'java'
cookbook 'build-essential'
cookbook 'runit', '1.1.6'


group :integration do
  cookbook "apt"
  cookbook "yum"
  cookbook "logstash_test", path: "test/cookbooks/logstash_test"
  # Future, when/if minitest support for this cookbook is added
  cookbook "minitest-handler"
end