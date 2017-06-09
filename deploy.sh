#!/bin/bash

# needs KBC_DEVELOPERPORTAL_USERNAME, KBC_DEVELOPERPORTAL_PASSWORD and KBC_DEVELOPERPORTAL_URL
docker pull quay.io/keboola/developer-portal-cli-v2:0.0.1
export REPOSITORY=`docker run --rm  -e KBC_DEVELOPERPORTAL_USERNAME=$KBC_DEVELOPERPORTAL_USERNAME -e KBC_DEVELOPERPORTAL_PASSWORD=$KBC_DEVELOPERPORTAL_PASSWORD -e KBC_DEVELOPERPORTAL_URL=$KBC_DEVELOPERPORTAL_URL quay.io/keboola/developer-portal-cli-v2:0.0.1 ecr:get-repository keboola keboola.docker-demo-sync`
docker tag keboola/docker-demo-sync-app:latest $REPOSITORY:$TRAVIS_TAG
docker tag keboola/docker-demo-sync-app:latest $REPOSITORY:latest
eval $(docker run --rm -e KBC_DEVELOPERPORTAL_USERNAME=$KBC_DEVELOPERPORTAL_USERNAME -e KBC_DEVELOPERPORTAL_PASSWORD=$KBC_DEVELOPERPORTAL_PASSWORD -e KBC_DEVELOPERPORTAL_URL=$KBC_DEVELOPERPORTAL_URL quay.io/keboola/developer-portal-cli-v2:0.0.1 ecr:get-login keboola keboola.docker-demo-sync)
docker push $REPOSITORY:$TRAVIS_TAG
docker push $REPOSITORY:latest

# deploy to testing AWS account
# needs AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY envvars
eval $(aws ecr get-login --region us-east-1)
docker tag keboola/docker-demo-sync-app:latest 061240556736.dkr.ecr.us-east-1.amazonaws.com/keboola/keboola.docker-demo-sync:$TRAVIS_TAG
docker tag keboola/docker-demo-sync-app:latest 061240556736.dkr.ecr.us-east-1.amazonaws.com/keboola/keboola.docker-demo-sync:latest
docker push 061240556736.dkr.ecr.us-east-1.amazonaws.com/keboola/keboola.docker-demo-sync:$TRAVIS_TAG
docker push 061240556736.dkr.ecr.us-east-1.amazonaws.com/keboola/keboola.docker-demo-sync:latest