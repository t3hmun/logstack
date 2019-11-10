# 2019-11-09 Elastic stack setup script - Manish

# This is a script to set things up for the before starting the servers.
# Its meant to illustrate what config has been done.
# Also verbosely commented to make it obviosu for bash/docker novices.

# This is a bash script you can run it in GitBash in Windows.


# Elastic stack  version number. 7.4.2 was the current at time of writing.
version='7.4.2'

# Make folders if they dont exist.
[ ! -d "./data" ] && mkdir data
[ ! -d "./data/elasticsearch" ] && mkdir data/elasticsearch
[ ! -d "./config" ] && mkdir config

# Copy the config files from the images as a reference.
# Diff these -default files against the configured ones to see what config has been done.
cpFile() {
    # Don't bother if the file already exists.
    if [ ! -f $3 ]; then
        # Create a temprary container, copy the file, delete the container.
        # You have to create a container to access the files.
        docker create --name temp $1
        docker cp temp:$2 $3
        docker container rm temp
    fi 
}

cpFile "docker.elastic.co/elasticsearch/elasticsearch:$version" "usr/share/elasticsearch/config/elasticsearch.yml" ./config/elasticsearch-default.yml
cpFile "docker.elastic.co/elasticsearch/elasticsearch:$version" "usr/share/elasticsearch/config/jvm.options" ./config/elasticsearch-jvm-default.options
cpFile "docker.elastic.co/kibana/kibana:$version" "usr/share/kibana/config/kibana.yml" ./config/kibana-default.yml
cpFile "docker.elastic.co/logstash/logstash:$version" "usr/share/logstash/config/logstash.yml" ./config/logstash-default.yml
cpFile "docker.elastic.co/apm/apm-server:$version" "usr/share/apm-server/apm-server.yml" ./config/apm-server-default.yml

