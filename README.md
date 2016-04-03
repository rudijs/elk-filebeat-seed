# elk-filebeat-seed

Centralized logging with Elasticsearch, Logstash, Kibana and Filebeat

## Overview

This code repository is a work in progress.

- Create a two tier AWS cluster
- Launch Docker containers of required software

## Usage

- TODO: terraform commands
- `sudo docker-compose up -d`
- `sudo docker-compose stop`

Kibana Sense Plugin

- `sudo docker exec -it kibana bash`
- `/opt/kibana/bin/kibana plugin --install elastic/sense`

Clean slate

- `sudo docker-compose down`

Notes:

- Remote
- mkdir /opt/{esdata,logstash}
- Fetch terraform modules into .terraform/
- terraform get
- export TF_VAR_aws_access_key=xxx-xxx-xxx-xxx
- export TF_VAR_aws_secret_key=xxx-xxx-xxx-xxx
- terraform apply
