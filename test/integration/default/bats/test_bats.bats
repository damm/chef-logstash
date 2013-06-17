#!/usr/bin/env bats

@test "elasticsearch is running" {
curl localhost:9200/_status?pretty=true
}

