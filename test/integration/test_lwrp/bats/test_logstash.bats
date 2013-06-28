#!/usr/bin/env bats

@test "it should have port 514 open for tcp and udp" {
[ $(netstat -lntu | grep 514 | wc -l) == 2 ]
}

@test "it should have a configuration file" {
[ -f "/opt/logstash/server/etc/logstash_indexer_systemlogs.conf" ]
}

@test "it should have patterns" {
[ -f "/opt/logstash/server/etc/patterns/linuxsyslog" ]
}

@test "it should have the free maxmind geoip database" {
[ -f "/opt/logstash/server/lib/GeoLiteCity.dat" ]
}
