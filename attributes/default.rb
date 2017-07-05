include_attribute "kagent"
include_attribute "ndb"
include_attribute "hops"
include_attribute "kzookeeper"
include_attribute "hopsworks"

default.hive2.user                    = node.install.user.empty? ? "hive" : node.install.user
default.hive2.group                   = node.install.user.empty? ? node.hops.group : node.install.user
default.hive2.version                 = "2.2.0-SNAPSHOT"
default.hive2.url                     = "#{node.download_url}/apache-hive-#{node.hive2.version}-bin-dev.tar.gz"
default.hive2.port                    = "9084"
default.hive2.dir                     = node.install.dir.empty? ? "/srv" : node.install.dir
default.hive2.home                    = node.hive2.dir + "/apache-hive-" + node.hive2.version + "-bin"
default.hive2.base_dir                = node.hive2.dir + "/apache-hive"
default.hive2.keystore                = "#{node.kagent.base_dir}/node_server_keystore.jks"
default.hive2.keystore_password       = "changeit"
default.hive2.execution_mode          = "llap"

default.hive2.mysql_user              = "hive"
default.hive2.mysql_password          = "hive"

default.hive2.server2.pid_file        = "/tmp/hiveserver2.pid"
default.hive2.metastore.pid_file      = "/tmp/hivemetastore.pid"
default.hive2.metastore.log           = "#{node.hive2.base_dir}/hive-metastore.log"
default.hive2.metastore.port         = "9083"
default.hive2.server2.log              = "#{node.hive2.base_dir}/hive-server2.log"
default.hive2.systemd                 = "true"

default.hive2.hive_cleaner.version   = "0.1.2"
default.hive2.hive_cleaner.url       = "#{node.download_url}/hivecleaner/#{node.platform}/hivecleaner-#{node.hive2.hive_cleaner.version}.tar.gz"
default.hive2.hive_cleaner.log       = "#{node.hive2.base_dir}/hive-cleaner.log"
default.hive2.hive_cleaner.pid_file  = "/tmp/hivecleaner.pid"

default.tez.user                    =  node.install.user.empty? ? "tez" : node.install.user
default.tez.group                   =  node.hops.group
default.tez.version                 = "0.8.5"
default.tez.url                     = "#{node.download_url}/apache-tez-#{node.tez.version}.tar.gz"
default.tez.dir                     =  node.install.dir.empty? ? "/srv" : node.install.dir
default.tez.home                    =  node.tez.dir + "/apache-tez-" + node.tez.version
default.tez.base_dir                =  node.tez.dir + "/apache-tez"
default.tez.hopsfs_dir              = "/apps/tez"
default.tez.conf_dir                =  node.tez.base_dir + "/conf"

default.slider.user                    =  node.install.user.empty? ? "slider" : node.install.user
default.slider.group                   =  node.hops.group
default.slider.version                 = "0.92.0"
default.slider.url                     = "#{node.download_url}/slider-#{node.slider.version}-incubating-all.tar.gz"
default.slider.dir                     =  node.install.dir.empty? ? "/srv" : node.install.dir
default.slider.home                    =  node.slider.dir + "/apache-slider-" + node.slider.version
default.slider.base_dir                =  node.slider.dir + "/apache-slider"

default.llap.cluster_name         = "llap-cluster"
default.llap.instance_size        = "3072"
default.llap.instance_headroom    = "256"
default.llap.instance_vcores      = "2"
default.llap.num_instances        = "2"
default.llap.num_executors        = "2"
default.llap.executors_memory     = "1024"
default.llap.io_cache             = "1024"
default.llap.execution_mode       = "auto"

#default.hive2.metastore.public_ips                   = ['']
#default.hive2.metastore.private_ips                  = ['']
#default.hive2.server2.public_ips                     = ['']
#default.hive2.server2.private_ips                    = ['']
#default.hive2['default']['public_ips']               = ['']
#default.hive2['default']['private_ips']              = ['']
