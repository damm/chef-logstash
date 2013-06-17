name             "logstash"
maintainer       "Scott M. Likens"
maintainer_email "scott@mopub.com"
license          "Apache 2.0"
description      "Installs/Configures logstash"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.7.1"

supports "ubuntu"

depends "build-essential"
depends "git"
depends "runit"
depends "python"
depends "java"
depends "logrotate"
depends "rabbitmq"
depends "redis_development"
depends "apt"
