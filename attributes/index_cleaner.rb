#
# Cookbook Name:: logstash
# Attribute:: index_cleaner

# How many days to keep?
default['logstash']['index_cleaner']['days_to_keep'] = 31
# Cron configuration hash
default['logstash']['index_cleaner']['cron'] = {
  'minute'   => '0',
  'hour'     => '*',
  'log_file' => '/dev/null'
}
