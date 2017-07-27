#!/usr/bin/env bash
scrum="scrum13"
for srv in "il" "ru" "uk" "us" "class-identity" "class-availability" "media" "ordering" "preeta" "clientgateway" "travelpolicy" "trip" "line" "depot" "location" "futureorder" "supplygateway" "saw" "invitation" "osrm" "liveheatmaps" "coupon" "fraud" "charging" "pricing" "subscription" "commission" "reports" "earnings" "rides" "regionidentity" "arm" "notification" "b2bgateway" "victory" "bookkeeping" "pms" "area" "auth" "hub" "driverportal" "developer" "paymentsubscription" "rating" "publicapi" "b2brides"; do
    echo ${srv}
    #clear crontabs
        #ssh -o "StrictHostKeyChecking no" -t eduardd@${srv}-${scrum}.gett.qa "sudo -u gtdeploy crontab -r;"
    #reboot machines
        #ssh -o "StrictHostKeyChecking no" -t eduardd@${srv}-${scrum}.gett.qa "sudo reboot"
    #restart eye services
       # ssh -o "StrictHostKeyChecking no" -t eduardd@${srv}-${scrum}.gett.qa "sudo service eye restart"
    #when deploy runs itself
        ssh -o "StrictHostKeyChecking no" -t eduardd@${srv}-${scrum}.gett.qa "sudo service chef-client stop"
done