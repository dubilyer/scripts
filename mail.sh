#!/usr/bin/env sh

body="failed tests on this nightly are: "

failed=$(cat /Users/dubilyer/Downloads/runner/log/current/report2.html | grep  "test_list_erro" | grep -o "Manual.*&lt;br/&gt;" | sed "s/ManualUcID=//g" |  sed "s/&lt;.*//g" | sed "s/\n/ /g")
echo $failed
for test in $failed; do
    if [[ $test == "S_C_"* || $test == "IL_"* ]] ; then
        hannas="$hannas $test,"
    fi
    if [[ $test == "BKPING_"* || $test == "IL_"* || $test == "Mobile"* || $test == "API"* || $test == "PMS"* || $test == *"_US_"* ]] ;  then
        avia="$avia $test,"
    fi
    if [[ $test == "UK_"* || $test == "SH_"* || $test == "CRE"* ]] ;  then
        saarr="$saarr $test,"
    fi
    if [[ $test == "RU_"* || $test == "RU_"* ]] ;  then
        guseinov="$guseinov $test,"
    fi
done

echo "hanna $hannas" | sed "s/,$/./g"
echo "saarr $saarr" | sed "s/,$/./g"
echo "avia $avia" | sed "s/,$/./g"
echo "guseinov $guseinov" | sed "s/,$/./g"




#| mailx -s "test" eduardd@gettaxi.com
