docker-compose up -d

curl http://localhost:9200

curl http://localhost:5601

docker exec -it <logstash-container-id> /bin/bash
echo "Hello ELK" | /usr/share/logstash/bin/logstash -f /usr/share/logstash/pipeline/logstash.conf

docker-compose down

docker-compose up -d

curl http://locahost:9200/_cat/indices?v
