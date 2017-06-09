#!/bin/bash

# needs KBC_DEVELOPERPORTAL_USERNAME, KBC_DEVELOPERPORTAL_PASSWORD and KBC_DEVELOPERPORTAL_URL
docker pull quay.io/keboola/developer-portal-cli-v2:0.0.1
export REPOSITORY=`docker run --rm  -e KBC_DEVELOPERPORTAL_USERNAME=$KBC_DEVELOPERPORTAL_USERNAME -e KBC_DEVELOPERPORTAL_PASSWORD=$KBC_DEVELOPERPORTAL_PASSWORD -e KBC_DEVELOPERPORTAL_URL=$KBC_DEVELOPERPORTAL_URL quay.io/keboola/developer-portal-cli-v2:0.0.1 ecr:get-repository keboola keboola.docker-demo-sync`
docker tag keboola/docker-demo-sync-app:latest $REPOSITORY:$TRAVIS_TAG
docker tag keboola/docker-demo-sybc-app:latest $REPOSITORY:latest
eval $(docker run --rm -e KBC_DEVELOPERPORTAL_USERNAME=$KBC_DEVELOPERPORTAL_USERNAME -e KBC_DEVELOPERPORTAL_PASSWORD=$KBC_DEVELOPERPORTAL_PASSWORD -e KBC_DEVELOPERPORTAL_URL=$KBC_DEVELOPERPORTAL_URL quay.io/keboola/developer-portal-cli-v2:0.0.1 ecr:get-login keboola keboola.docker-demo-sync)
docker push $REPOSITORY:$TRAVIS_TAG
docker push $REPOSITORY:latest
