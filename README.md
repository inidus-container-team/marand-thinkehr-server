# Marand Think!EHR Server

Provides a docker container for Marand Think!EHR Server.

## Getting Started
These instructions will get you a Think!EHR CDR service up and running on your local machine for development and testing purposes.

### Build the container image manually
  - Extract vendor provided server.tar.gz server-jsw.tar.gz into `thinkehr` directory
  - Build with `docker build . -t marand-thinkehr`

### Build and tag versions of container image automagically
  - Place all the vendor server.tar.gz & server-jsw.tar.gz files in the `source` directory
  - Build with `./build.sh build <tag>`
  - Push to docker hub with `./build.sh push <tag>`


## Run locally with docker-compose
  - Start database service `docker-compose -f docker-compose.yml up -d thinkehr-db`
  - Initialise database `docker-compose -f docker-compose.yml run thinkehr-app ./bin/initdb.sh`
  - Start ThinkEHR service `docker-compose -f docker-compose.yml up -d thinkehr-app`
  - Wait a few minutes....
  - Open [http://127.0.0.1:8080](http://127.0.0.1:8080) in a browser and login with username: _admin_ and password: _admin_


## Deploy to swarm using docker stack

- Start the database service `docker stack deploy -c stack-db.yml test`
- Initialise database `docker stack deploy -c stack-app.yml -c stack-app-initdb.yml test`
- Start the app service `docker stack deploy -c stack-app.yml test`
- Watch the logs `docker service logs test_thinkehr-app -f`
- Expose the service ports to the host `docker service update test_thinkehr-app --publish-add 8080:8080`
- Open [http://<swarm ip>:8080](http://<swarm ip>:8080) in a browser and login with username: _admin_ and password: _admin_

Create initial database
- `docker run --rm -t -v `pwd`/conf/system.properties:/thinkehr/conf/system.properties --network=thinkehr registry.inidus.ovh/marand-thinkehr-app ./bin/initdb.sh`


## Backup database

    docker exec test_thinkehr-db.1.x5ohlgtbcyrmr52he38rryu7m pg_dump --dbname=postgresql://thinkehr:thinkehr@thinkehr-db:5432/thinkehr > thinkehr-`date +"%m%d%y%H%M%S"`.sql
