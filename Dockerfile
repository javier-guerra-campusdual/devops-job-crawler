FROM ubuntu:20.04

ENV ES_VERSION=8.12.1
ENV ES_HOME=/opt/elasticsearch-${ES_VERSION}

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && \
    apt-get install -y \
    openjdk-11-jdk \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Download and extract Elasticsearch
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VERSION}-linux-x86_64.tar.gz -P /opt && \
    tar -xzf /opt/elasticsearch-${ES_VERSION}-linux-x86_64.tar.gz -C /opt && \
    rm /opt/elasticsearch-${ES_VERSION}-linux-x86_64.tar.gz

# Copy configuration files
COPY elasticsearch.yml ${ES_HOME}/config/elasticsearch.yml
COPY start.sh /opt/start.sh

# Set permissions
RUN chmod -R 777 /opt && \
    chmod +x /opt/start.sh

# Add elasticsearch user
RUN useradd elasticsearch && \
    echo "elasticsearch:campusdual" | chpasswd && \
    adduser elasticsearch sudo && \
    chown -R elasticsearch:elasticsearch ${ES_HOME}

# Switch to elasticsearch user
USER elasticsearch

# Set working directory
WORKDIR ${ES_HOME}

# Expose Elasticsearch ports
EXPOSE 9200 9300

CMD ["/opt/start.sh"]