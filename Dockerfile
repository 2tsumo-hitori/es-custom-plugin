FROM docker.elastic.co/elasticsearch/elasticsearch:7.9.1
WORKDIR /usr/share/elasticsearch
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install https://github.com/2tsumo-hitori/es-custom-plugin/raw/main/7.9.1/javacafe-analyzer-7.9.1.zip
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install https://github.com/likejazz/seunjeon-elasticsearch-7/releases/download/7.9.1/analysis-seunjeon-7.9.1.zip
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-nori
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-icu
