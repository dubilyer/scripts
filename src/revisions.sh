#!/usr/bin/env bash
scrum="scrum21"
rm revisions${scrum}.txt
for srv in "il" "ru" "uk" "us"; do
    printf "${srv}"
    printf "${srv}=" >> revisions${scrum}.txt
    curl -X GET http://${srv}-${scrum}.gett.io/alive | jq -r '.git_revision' >> revisions${scrum}.txt
done

for srv in "auth" "invitation" "depot" "pms" "class-identity" "class-availability" "media" "ordering"  "earnings" "travelpolicy" "trip" "line"  "futureorder" "coupon" "charging" "pricing" "commission" "notification" "area" "bookkeeping" "driverportal"; do
    printf "${srv}"
    printf "${srv}=" >> revisions${scrum}.txt
    curl -X GET http://${srv}-${scrum}.gett.io/alive | jq -r '.git_revision' >> revisions${scrum}.txt
done

for srv in "matchingstrategy" "matching" "driversqueue" "companyregistration" "loadindex" "preeta" "clientgateway" "location" "supplygateway" "lineeta" "fraud" "rides" "matchingaudit" "webhook" "reports" "regionidentity" "arm"  ; do
    printf "${srv}"
    printf "${srv}=" >> revisions${scrum}.txt
    curl -X GET http://${srv}-${scrum}.gett.io/alive | jq -r '.commit' >> revisions${scrum}.txt


done

#problems on scrum21
for srv in "chargingbi" "b2bgateway" "developer" "digitalinvoice" "estimation" "planride" "surge"; do
    printf "${srv}"
    printf "${srv}=" >> revisions${scrum}.txt
    echo "master" >> revisions${scrum}.txt
done
sed "s/class-//g"  revisions${scrum}.txt
#sed "s/\r/:/g"

