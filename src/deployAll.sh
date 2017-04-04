#!/usr/bin/env bash
scrum="scrum8"
for srv in   "ru" "us" "uk" "pms" "class-identity" "class-availability" "media" "ordering" "preeta" "clientgateway" "travelpolicy" "trip" "line" "depot" "location" "futureorder" "supplygateway" "saw" "invitation" "osrm" "liveheatmaps" "coupon" "fraud" "charging" "pricing" "subscription" "commission" "reports" "earnings" "rides" "regionidentity" "arm" "notification" "b2bgateway" "victory" "area" "bookkeeping"; do
    ssh eduardd@${srv}-${scrum}.gett.qa -oStrictHostKeyChecking=no -t bash -ci deploy >${srv}.txt
done