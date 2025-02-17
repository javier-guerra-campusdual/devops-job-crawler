#!/bin/bash

ES_VERSION="8.17.2"
ES_HOME="/opt/elasticsearch-${ES_VERSION}"

# Check if Elasticsearch directory exists
if [ ! -d "$ES_HOME" ]; then
    echo "Error: Elasticsearch directory not found at $ES_HOME"
    exit 1
fi

# Start Elasticsearch
cd $ES_HOME
bin/elasticsearch