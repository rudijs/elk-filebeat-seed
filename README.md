# elk-filebeat-seed

Centralized logging with Elasticsearch, Logstash, Kibana and Filebeat

## Overview

This code repository is a work in progress.

1. Terraform - Create a two tier AWS cluster
2. docker-machine and docker-compose - Launch Docker containers of required software

The two tier AWS cluster consists of 2 machines:

- Database (ELK + Filebeat)
- Bastion (Filebeat)

The Bastion server runs OpenVPN and it's through this machine that you connect to the database.

The Database server accesses the internet via the Bastion (NAT forwarding).

Each machine that needs to ship logs to the ELK stack will run Filebeat.

When terraform completes and the two machines are up:

1. docker-machine will install Docker onto each machine.
2. docker-compose will launch an ELK stack of containers on the Database.
2. docker-compose will launch a Filebeat container on both Database and Bastion.

## Usage

- First setup your AWS access and secret keys as environment variables:
- `export TF_VAR_aws_access_key=xxx-xxx-xxx-xxx`
- `export TF_VAR_aws_secret_key=xxx-xxx-xxx-xxx`
- Import the terraform modules into .terraform/
- `terraform get`
- Check out terraform plan
- `terraform plan`
- Start up a new two tier AWS cluster
- `terraform apply`
- TODO: complete the separe docker-machine and docker-compose commands
- TODO: sudo docker-compose up -d
- TODO: sudo docker-compose stop

Kibana Sense Plugin

- `sudo docker exec -it kibana bash`
- `/opt/kibana/bin/kibana plugin --install elastic/sense`

Clean slate

- `sudo docker-compose down`

TODO Notes:

- Remote
- mkdir /opt/{esdata,logstash}
