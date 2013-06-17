Description
=======================

This is an fork of the semi-official 'all-in-one' Cookbook.  It has been reduced to a simple installation method and a resource and provider to configure Logstash.

Requirements
------------

 * Java cookbook from Opscode
 * Runit cookbook From Opscode
 * Elasticsearch cookbook of your choice

> What is tested is in The Berksfile

Attributes
----------

> Note only the attributes used are listed below.

## logstash::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['logstash']['basedir']</tt></td>
    <td>String</td>
    <td>Base Directory where logstash is installed</td>
    <td><tt>/opt/logstash</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['user']</tt></td>
    <td>String</td>
    <td>Username to run logstash as</td>
    <td><tt>logstash</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['group']</tt></td>
    <td>String</td>
    <td>Group Name to run logstash as</td>
    <td><tt>logstash</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['join_groups']</tt></td>
    <td>Array</td>
    <td>An array of Operative System groups to join. Usefull to gain read privileges on some logfiles.</td>
    <td><tt><code>[]</code></tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['create_account']</tt></td>
    <td>[TrueClass, FalseClass]</td>
    <td>Create account, info from `user` and `group` is used.</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## logstash::server

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['logstash']['server']['install_method']</tt></td>
    <td>String</td>
    <td>How to install logstash? either <code>source</code> or <code>jar</code></td>
    <td><tt>jar</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['server']['version']</tt></td>
    <td>String</td>
    <td>The version of Logstash to install.  Only applies to <code>jar</code> installation method.</td>
    <td><tt>1.1.12</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['server']['source_url']</tt></td>
    <td>String</td>   
    <td>The URL of the Logstash jar to download.</td>
    <td><tt>https://logstash.objects.dreamhost.com/release/logstash-1.1.12-flatjar.jar</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['server']['checksum']</tt></td>
    <td>String</td>
    <td>The checksum of the jar file.  Only applies to the <strong>jar</strong> install method.</td>
    <td><tt>e75bce7c88461116fbd2c7c473d8c8999c152ab6c618caa58b3d0d88feeb77fd</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['server']['xmx']</tt></td>
    <td>String</td>
    <td>The maximum memory to assign to the JVM.</td>
    <td><tt>1024M</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['server']['java_opts']</tt></td>
    <td>String</td>
    <td>Additional params you want to pass to the JVM</td>
  </tr>
  <tr>
    <td><tt>['logstash']['server']['gc_opts']</tt></td>
    <td>String</td>
    <td>Specify your garbage collection options to pass to the JVM</td>
    <td><tt><code>-XX:+UseParallelOldGC</code></tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['server']['ipv4_only']</tt></td>
    <td>[TrueClass, FalseClass]</td>
    <td>Prefer the IPv4 stack?</td>
    <td><tt><code>false</code></tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['server']['debug']</tt></td>
    <td>[TrueClass, FalseClass]</td>
    <td>Run logstash with <strong>-v</strong> option?</td>
    <td><tt><code>false</code></tt></td>
  </tr>
</table>

## logstash::source

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['logstash'][['source']['repo']</tt></td>
    <td>String</td>
    <td>The git repo to use for the logstash source code of Logstash</td>
    <td><tt>git://github.com/logstash/logstash.git</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['source']['sha']</tt></td>
    <td>String</td>
    <td>The sha/branch/tag of the repo  you wish to clone. Uses <code>node['logstash']['server']['version']</code> by default.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['source']['java_home']</tt></td>
    <td>String</td>
    <td>your <code>JAVA_HOME</code> location. Needed explicity for <code>ant</code> when building JRuby</td>
    <td><tt>/usr/lib/jvm/java-6-openjdk/</tt></td>
  </tr>
</table>


## logstash::index_cleaner

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['logstash']['index_cleaner']['days_to_keep']</tt></td>
    <td>Fixnum</td>
    <td>number of days from today of Logstash index to keep.</td>
    <td><tt>31</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['index_cleaner']['cron']['minute']</tt></td>
    <td>String</td>
    <td>Minute to run the index_clleaner cron job</td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['index_cleaner']['hour']</tt></td>
    <td>String</td>
    <td>Hour to run the index_cleaner cron job</td>
    <td><tt><code>*</code></tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['index_cleaner']['cron']['log_file']</tt></td>
    <td>String</td>
    <td>Path to direct the index_Cleaners cron job's stdout and stderr to</td>
    <td><tt><code>/dev/null</code></tt></td>
  </tr>
</table>

Resources and Providers
=======================

This cookbook provides an resource and an corresponding provider.

`indexer.rb`
-------------

Actions:

* `create` - create a logstash indexer

Attribute Parameters:

## logstash::indexer

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>basedir</tt></td>
    <td>String</td>
    <td>Base path of where to install logstash to</td>
    <td><tt>/opt/logstash</tt></td>
  </tr>
  <tr>
    <td><tt>user</tt></td>
    <td>String</td>
    <td>Default username logstash runs as</td>
    <td><tt>logstash</tt></td>
  </tr>
  <tr>
    <td><tt>group</tt></td>
    <td>String</td>
    <td>Group that the logstash user belongs to</td>
    <td><tt>logstash</tt></td>
  </tr>
  <tr>
    <td><tt>log_dir</tt></td>
    <td>String</td>
    <td>Log directory to store logstash console logs</td>
    <td><tt>/var/log/logstash</tt></td>
    </tr>
  <tr>
    <td><tt>pid_dir</tt></td>
    <td>String</td>
    <td>/var/run/logstash</td>
    <td><tt>/var/run/logstash</tt></td>
  </tr>
  <tr>
    <td><tt>patterns_dir</tt></td>
    <td>String</td>
    <td>Directory where to store the pattern files at</td>
    <td><tt><code>new_resource.basedir + </code>"server/etc/patterns"</tt></td>
  </tr>
  <tr>
    <td><tt>base_config</tt></td>
    <td>String</td>
    <td>The name of the template to use for generating server configuration files</td>
    <td><tt>server.conf.erb</tt></td>
  </tr>
  <tr>
    <td><tt>base_config_cookbook</tt></td>
    <td>String</td>
    <td>Specifies where to find the template to use for the template specified in <code>base_config</code></td>
    <td><tt>logstash</tt></td>
  </tr>
  <tr>
    <td><tt>xms</tt></td>
    <td>String</td>
    <td>The minimum memory to assign the JVM.</td>
    <td><tt>1024M</tt></td>
  </tr>
  <tr>
    <td><tt>xmx</tt></td>
    <td>String</td>
    <td>The maximum memory to assign the JVM.</td>
    <td><tt>1024M</tt></td>
  </tr>
  <tr>
    <td><tt>java_opts</tt></td>
    <td>String</td>
    <td>Additional params you want to pass to the JVM</td>
    <td><tt>String.new</tt></td>
  </tr>
  <tr>
    <td><tt>gc_opts</tt></td>
    <td>String</td>
    <td>Specify your garbage collection options to pass to the JVM</td>
    <td><tt>-XX:+UseParallelOldGC</tt></td>
  </tr>
  <tr>
    <td><tt>ipv4_only</tt></td>
    <td>[TrueClass, FalseClass]</td>
    <td>Add jvm option preferIPv4Stack?</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>filters</tt></td>
    <td>Array</td>
    <td>Specifies what filters should be used in the indexer</td>
  </tr>
  <tr>
    <td><tt>inputs</tt></td>
    <td>Array</td>
    <td>Specifies what inputs should be used in the indexer</td>
  </tr>
  <tr>
    <td><tt>patterns</tt></td>
    <td>Array</td>
    <td>Specifies what grok and multiline filters should be made <strong>available</strong>to the indexer</td>
  </tr>
  <tr>
    <td><tt>output</tt></td>
    <td>Array</td>
    <td>Specifies where to output and how</td>
  </tr>
</table>


Usage
-----

```ruby
include_recipe "redis"  
include_recipe "rabbitmq::default"  
  logstash_indexer "syslog" do  
    inputs([  
      :redis => {  
      :type => "redis-int",  
      :host => "127.0.0.1",  
      :data_type => "list",  
      :key => "systemlogs:beaver",  
      :format => "json_event"  
      }])  
  patterns([  
      :linuxsyslog => {  
      :SYSLOGBASE2 => "(?:%{SYSLOGTIMESTAMP:timestamp}|%{TIMESTAMP_ISO8601:timestamp8601}) (?:%{SYSLOGFACILITY} )?%{SYSLOGHOST:logsource} %{SYSLOGPROG}:",  
      :SYSLOGPAMSESSION => "%{SYSLOGBASE} (?=%{GREEDYDATA:message})%{WORD:pam_module}\(%{DATA:pam_caller}\): session %{WORD:pam_session_state} for user %{USERNAME:username}(?: by %{GREEDYDATA:pam_by})?",  
      :CRON_ACTION => "[A-Z ]+",  
      :CRONLOG => "%{SYSLOGBASE} \(%{USER:user}\) %{CRON_ACTION:action} \(%{DATA:message}\)",  
      :SYSLOGLINE => "%{SYSLOGBASE2} %{GREEDYDATA:message}",  
      # IETF 5424 syslog(8) format (see http://www.rfc-editor.org/info/rfc5424)  
      :SYSLOG5424PRI => "(?:\<%{NONNEGINT}\>)",  
      :SYSLOG5424SD => "(?:\[%{DATA}\]+|-)",  
      :SYSLOG5424LINE => "%{SYSLOG5424PRI:syslog5424_pri}%{NONNEGINT:syslog5424_ver} (%{TIMESTAMP_ISO8601:syslog5424_ts}|-) (%{HOSTNAME:syslog5424_host}|-) (%{WORD:syslog5424_app}|-) (%{WORD:syslog5424_proc}|-) (%{WORD:syslog5424_msgid}|-) %{SYSLOG5424SD:syslog5424_sd} %{GREEDYDATA:syslog5424_msg}"  
      }])  
  filters([  
      :grok => {  
      :type => "linuxsyslog",  
      :pattern => "%{SYSLOGLINE}"  
      }])  
  output([  
      :elasticsearch_http => {  
      :host => "localhost",  
      :port => 9200,  
      :index => "systemlogs-%{+YYYY.MM.dd}",  
      :flush_size => 1  
      },  
      :graphite => {  
      :host => "localhost",   
      :port => 2013,  
      :metrics => ["logstash.systemlogs.events", "1"]  
      }])  
  action :create  
end
```

## Source vs. Jar install methods

Both `agent` and `server` support an attribute for how to install. By
default this is set to `jar` to use the 1.1.1preview as it is required
to use elasticsearch 0.19.4. The current release is defined in
attributes if you choose to go the `source` route.

## Suggested Usage

```shell
knife cookbook create orgname_logstash
```

* Ensure this cookbook depends on this logstash cookbook
  ```ruby depends "logstash"```

* Determine how you want to implement your settings, load them in a recipe _like in the usage above_ or load the data in a data bag; and create a recipe to load said data bag to consume and create your logstash instances

> No implementation details are provided for configuring RabbitMQ, Redis or any input methods.  Nor are there any limitations in the configuration

  * Determine how you want to ship logs to logstash?

> Other cookbooks should provide shippers to logstash.  This cookbook aims only support the logstash server.

## License and Author

- Author:    Scott M. Likens
- Author:    John E. Vincent
- Author:    Bryan W. Berry (<bryan.berry@gmail.com>)
- Author:    Richard Clamp (@richardc)
- Author:    Juanje Ojeda (@juanje)
- Author:    @benattar
- Copyright: 2013, Scott M. Likens
- Copyright: 2012, John E. Vincent
- Copyright: 2012, Bryan W. Berry
- Copyright: 2012, Richard Clamp
- Copyright: 2012, Juanje Ojeda
- Copyright: 2012, @benattar

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
