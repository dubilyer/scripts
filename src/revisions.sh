#!/usr/bin/env bash
scrum="scrum8"
rm revisions{scrum}.txt
for srv in "il" "ru" "uk" "us"; do
    printf "${srv}"
    printf "${srv}=" >> revisions${scrum}.txt
    curl -X GET http://${srv}-${scrum}.gett.qa/alive | jq -r '.git_revision' >> revisions${scrum}.txt
done
for srv in "pms" "class-identity" "class-availability" "media" "ordering" "travelpolicy" "trip" "line" "depot" "futureorder" "invitation" "coupon" "charging" "pricing" "commission" "notification" "area" "bookkeeping"; do
    printf "${srv}"
    printf "${srv}=" >> revisions${scrum}.txt
    curl -X GET http://${srv}-${scrum}.gett.qa/alive | jq -r '.git_revision' >> revisions${scrum}.txt
done
for srv in "preeta" "clientgateway" "location" "supplygateway" "fraud"  "reports"  "rides" "regionidentity" "arm" "b2bgateway"; do
    printf "${srv}"
    printf "${srv}=" >> revisions${scrum}.txt
    curl -X GET http://${srv}-${scrum}.gett.qa/alive | jq -r '.commit' >> revisions${scrum}.txt
done
#sed "s/\r/:/g"

#"saw" "victory" "osrm" "invitation" "liveheatmaps" "earnings" "subscription"