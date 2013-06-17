logstash_indexer "logstash_indexer_" + "systemlogs" do
  inputs([
          { :redis => {
            :type => "redis-int",
            :host => "127.0.0.1",
            :data_type => "list",
            :key => "systemlogs:logstash",
            :threads => 8,
            :format => "json_event"
            } } ,
          { :udp => {
              :port => 514,
              :type => "syslog"
            } } ,
          { :tcp => {
              :port => 514,
              :type => "syslog"
            } }
         ])
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
           { :grok => {
               :type => "syslog",
               :pattern => [ "<%{POSINT:syslog_pri}>%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}" ],
             } }, 
           { :syslog_pri => {
               :type => "syslog"
             } },
           { :date => {
               :type => "syslog",
               :match => [ "MMM  d HH:mm:ss", "MMM dd HH:mm:ss", "ISO8601" ]
             } },
          { :mutate => {
             :type => "syslog",
             :exclude_tags => "_grokparsefailure",
             :replace => [ "@source_host", "%{syslog_hostname}" ]
           } },
          { :mutate => {
             :type => "syslog",
             :exclude_tags => "_grokparsefailure",
             :replace => [ "@message", "%{syslog_message}" ]
           } },
           { :json => {
               :source => "@message",
               :type => "data",
               :type => "apache"
             } },
          ])
  output([
          :elasticsearch_http => {
            :host => "localhost",
            :port => 9200,
            :index => "systemlogs-%{+YYYY.MM.dd}",
            :flush_size => 1,
          }])            
  action :create
end
