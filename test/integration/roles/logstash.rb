name "logstash"
description "Logstash server"
run_list "recipe[mopub_redis::client_no_bgsave]",
         "recipe[elasticsearch::default]",
         "recipe[logstash::server]"
