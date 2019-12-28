#!/usr/bin/env bash

UNIXTIME=$(date +%s)

docker build -f Dockerfile.prod -t cloud.canister.io:5000/skoba/health-checker:build-$UNIXTIME .
docker push cloud.canister.io:5000/skoba/health-checker:build-$UNIXTIME

helm upgrade -i --set app.image.tag=build-$UNIXTIME --wait --namespace default healthchecker ./chart
