#!/usr/bin/sh
#run the job and get it's queue id
queue=`curl -i -X  POST http://ci.gtforge.com:8080/job/Automation-scrum-deploy/buildWithParameters\?ACTION\=tag_scrum\&SCRUM_ORIGIN\=scrum10\&SCRUM_NAME\=scrum19  --user livnata:867b08925d839273494b8bd9d17f90309486c83e | grep queue | sed -e 's/^Location: //g' | sed -e 's/8080//g' | sed -e 's/[^0-9]//g'`
echo $queue
currentQueue="-1"
#waiting for job start
while [ "$currentQueue" != "$queue" ]; do
    currentQueue=`curl -X GET http://ci.gtforge.com:8080/job/Automation-scrum-deploy/lastBuild/api/json --user livnata:867b08925d839273494b8bd9d17f90309486c83e | jq ".queueId"`
    echo $currentQueue $queue
done
#get job ID
buildNumber=`curl -X GET http://ci.gtforge.com:8080/job/Automation-scrum-deploy/lastBuild/api/json --user livnata:867b08925d839273494b8bd9d17f90309486c83e | jq ".number"`
echo $buildNumber
result="null"
#waiting for job finish
while [ "$result" = "null" ]; do
    result=`curl -X GET http://ci.gtforge.com:8080/job/Automation-scrum-deploy/lastBuild/api/json --user livnata:867b08925d839273494b8bd9d17f90309486c83e | jq ".result"`
    echo $result
done
