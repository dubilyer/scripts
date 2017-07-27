#!/usr/bin/env bash

cd ~/services/

#git clone git@github.com:gtforge/gtforge_server.git

for srv in "class_identity" "class_availability" "media" "ordering" "preeta" "clientgateway" "travelpolicy" "trip" "line" "depot" "location" "futureorder" "supplygateway" "saw" "invitation" "osrm" "liveheatmaps" "coupon" "fraud" "charging" "pricing" "subscription" "commission" "reports" "earnings" "rides" "regionidentity" "arm" "notification" "b2bgateway" "victory"; do
 #   do
    rm -rf ${srv}_service
    git clone git@github.com:gtforge/${srv}_service.git
    srv=${srv//_/-}
    echo $srv
    file="../revisions.txt"

if [ -f "$file" ]
then
  echo "$file found."

    while IFS='=' read -r key value
    do
        echo $key
        key=$(echo $key)
        eval "${key}='${value}'"
        echo $value
    done < $file
    fi
    echo ${il}

        #git checkout
         #git fetch --tags; git tag -a -m “dubilyer” -f scrum10; git push -f origin scrum10
done

