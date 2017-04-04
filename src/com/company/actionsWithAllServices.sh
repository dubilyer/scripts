#!/usr/bin/env bash
scrum="scrum19"
for srv in "il" "ru" "uk" "us" "class-identity" "class-availability" "media" "ordering" "preeta" "clientgateway" "travelpolicy" "trip" "line" "depot" "location" "futureorder" "supplygateway" "saw" "invitation" "osrm" "liveheatmaps" "coupon" "fraud" "charging" "pricing" "subscription" "commission" "reports" "earnings" "rides" "regionidentity" "arm" "notification" "b2bgateway" "victory" "bookkeeping" "pms" "area"; do
    #clear crontabs
    ssh -o "StrictHostKeyChecking no" -t eduardd@${srv}-${scrum}.gett.qa "sudo -u gtdeploy crontab -r;"
    #reboot machines
    #ssh -o "StrictHostKeyChecking no" -t eduardd@${srv}-${scrum}.gett.qa "sudo reboot"
done