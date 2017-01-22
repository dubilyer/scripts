#!/usr/bin/sh
user='Munir-b:cc2c8e094fec6fe8a77eb45c9656050f'
function sendAndWait() {
    #run the job and get it's queue id
    queue=`curl -i -X  POST http://ci.gtforge.com:8080/job/$1/buildWithParameters\?$2  --user $user | grep queue | sed -e 's/^Location: //g' | sed -e 's/8080//g' | sed -e 's/[^0-9]//g'` > /dev/null 2>&1
    echo $queue
    currentQueue="-1"
    #waiting for job start
    while [ "$currentQueue" != "$queue" ]; do
        currentQueue=`curl -X GET http://ci.gtforge.com:8080/job/$1/lastBuild/api/json --user $user | jq ".queueId"` > /dev/null 2>&1
        echo $currentQueue $queue
    done
    #get job ID
    buildNumber=`curl -X GET http://ci.gtforge.com:8080/job/$1/lastBuild/api/json --user $user | jq ".number"` > /dev/null 2>&1
    echo $buildNumber
    result="null"
    #waiting for job finish
    while [ "$result" = "null" ]; do
        result=`curl -X GET http://ci.gtforge.com:8080/job/$1/lastBuild/api/json --user $user | jq ".result"` > /dev/null 2>&1
        echo $result
    done
}
sendAndWait $1 $2
#"Automation-scrum-deploy" "ACTION\=tag_scrum\&SCRUM_ORIGIN\=scrum10\&SCRUM_NAME\=scrum19"
