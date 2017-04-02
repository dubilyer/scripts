#!/usr/bin/env bash
scrum="scrum18"
rm revisions.txt
for srv in "il" "ru" "uk" "us"; do
    printf "${srv}=" >> revisions.txt
    curl -X GET http://${srv}-scrum18.gett.qa/alive | jq -r '.git_revision' >> revisions.txt
done
for srv in "class-identity" "class-availability" "media" "ordering" "travelpolicy" "trip" "line" "depot" "futureorder" "invitation" "coupon" "charging" "pricing" "commission" "notification" "area" "bookkeeping"; do
    printf "${srv}=" >> revisions.txt
    curl -X GET http://${srv}-scrum18.gett.qa/alive | jq -r '.git_revision' >> revisions.txt
done
for srv in "preeta" "clientgateway" "location" "supplygateway" "fraud"  "reports"  "rides" "regionidentity" "arm" "b2bgateway"; do
    printf "${srv}=" >> revisions.txt
    curl -X GET http://${srv}-scrum18.gett.qa/alive | jq -r '.commit' >> revisions.txt
done
sed "s/\r/:/g"

#"saw" "victory" "osrm" "invitation" "liveheatmaps" "earnings" "subscription"