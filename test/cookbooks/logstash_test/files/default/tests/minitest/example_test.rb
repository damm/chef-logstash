
# Cookbook Name:: logstash_test
# Recipe:: test_lwrp
#
# Copyright 2012, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require File.expand_path('../support/helpers', __FILE__)
require 'net/http'
require 'socket'
require 'stretcher'
require 'time'
now = DateTime.now
indice = "logstash-#{now.strftime("%Y")}.#{now.strftime("%m")}.#{now.strftime("%d")}"
ipsum = "Oh mighty Arkleseizure, thou gazed from high above. And sneezed from out thy nostrils, a gift of bounteous love. The universe around us emerged from thy nose. Now we await with eager expectation, thy handkerchief, to bring us back to thee. "

describe "logstash_test::default" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  it "logstash_indexer_systemlogs should be running" do
    service("logstash_indexer_systemlogs").must_be_running
  end
  it "should wait for logstash to come up" do
    sleep 65
  end
  it "should be able to query elasticsearch" do
    uri = URI.parse("http://localhost:9200")
    Net::HTTP.get(uri)
    res = Net::HTTP.get_response(uri)
    return res.is_a?(Net::HTTPSuccess)
  end
  it "should be able to connect to udp port 514 and send messages" do
    u1 = UDPSocket.new
   # u2 = u1.connect("127.0.0.1", 514)
    u1.send(ipsum, 0, "127.0.0.1", 514)
  end
  it "should be able to connect to tcp port 514 and send messages" do
    t1 = TCPSocket.new('127.0.0.1', 514)
   #  t2 = t1.connect("127.0.0.1", 514)
    t1.write(ipsum)
  end
  it "should take a nap" do
    sleep 10
  end
  it "should have data in logstashes index" do
    server = Stretcher::Server.new('http://localhost:9200')
    assert server.index(indice).msearch([{query: {match_all: {}}}])
  end
end
