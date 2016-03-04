# elk-filebeat-seed
Centralized logging with Elasticsearch, Logstash, Kibana and Filebeat

## Usage

- `sudo docker-compose up -d`
- `sudo docker-compose stop`

Kibana Sense Plugin

- `sudo docker exec -it kibana bash`
- `/opt/kibana/bin/kibana plugin --install elastic/sense`

Clean slate

- `sudo docker-compose down`



Remote
mkdir /opt/{esdata,logstash}