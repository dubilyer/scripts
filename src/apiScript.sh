#!/usr/bin/sh
curl -i -X  POST http://ci.gtforge.com:8080/job/Automation-scrum-deploy/buildWithParameters\?ACTION\=tag_scrum\&SCRUM_ORIGIN\=scrum10\&SCRUM_NAME\=scrum19  --user livnata:867b08925d839273494b8bd9d17f90309486c83e | grep queue | sed -e 's/^Location: //g' | sed -e 's/8080//g' | sed -e 's/[^0-9]//g'> api.tmp
read queue < api.tmp
echo $queue
currentQueue="-1"
while [ "$currentQueue" != "$queue" ]; do
    curl -X GET http://ci.gtforge.com:8080/job/Automation-scrum-deploy/lastBuild/api/json --user livnata:867b08925d839273494b8bd9d17f90309486c83e | jq ".queueId" > api.tmp
    read currentQueue < api.tmp
    echo $currentQueue $queue
done
curl -X GET http://ci.gtforge.com:8080/job/Automation-scrum-deploy/lastBuild/api/json --user livnata:867b08925d839273494b8bd9d17f90309486c83e | jq ".number" > api.tmp
read buildNumber < api.tmp
echo $buildNumber
result="null"
while [ "$result" = "null" ]; do
    curl -X GET http://ci.gtforge.com:8080/job/Automation-scrum-deploy/lastBuild/api/json --user livnata:867b08925d839273494b8bd9d17f90309486c83e | jq ".result" > api.tmp
    read result < api.tmp
    echo $result
done
