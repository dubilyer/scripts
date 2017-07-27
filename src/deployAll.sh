#!/usr/bin/env bash
scrum="scrum19"
for srv in   "ru" "us" "uk" "pms" "class-identity" "class-availability" "media" "ordering" "preeta" "clientgateway" "travelpolicy" "trip" "line" "depot" "location" "futureorder" "supplygateway" "saw" "invitation" "osrm" "liveheatmaps" "coupon" "fraud" "charging" "pricing" "subscription" "commission" "reports" "earnings" "rides" "regionidentity" "arm" "notification" "b2bgateway" "victory" "area" "bookkeeping" "auth" "hub" "driverportal" "developer" "paymentsubscription" "rating" "publicapi" "b2brides"; do
    ssh eduardd@${srv}-${scrum}.gett.qa -oStrictHostKeyChecking=no -t bash -ci deploy >${srv}.txt
    ssh -o "StrictHostKeyChecking no" -t eduardd@${srv}-${scrum}.gett.qa "sudo service chef-client stop"
done