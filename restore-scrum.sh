#!/usr/bin/env bash
SCRUM="scrum8"

function displayParameters(){
echo "--------------------"
echo "host: " $HOST
echo "pguser: " $PGUSER
echo "pgdb: " $PGDB
echo "service: "$SERVICE
echo "--------------------"

}



function restore_service(){
echo "host: " $HOST
echo "pguser: " $PGUSER
echo "pgdb: " $PGDB
echo "service: " $SERVICE

echo "validating db user exists"
if [[ -z "`grep $PGUSER ~/.pgpass`" ]]; then echo "$HOST:5432:$PGUSER:$PGUSER:$PGUSER" >> ~/.pgpass;  else echo "User already exists"; fi

echo "executing clean database"
pwd
NUMBER=$(echo "$PGUSER" | sed 's/[^0-9]*//g')
sed  -i "s/scrum10/scrum$NUMBER/g" ~/$DUMPPATH/$SERVICE.dump.out
#sed  -i "s/scrum10/scrum$NUMBER/g" ~/$DUMPPATH/$SERVICE.toc

set +e
psql -h $HOST -d $PGDB -U root -c "select pg_terminate_backend(pid) from pg_stat_activity where datname='$PGDB'"
psql -h $HOST -d $PGDB -U root -c "ALTER DATABASE $PGDB OWNER TO root"
psql -h $HOST -d postgres -U root -c "drop database $PGDB"
psql -h $HOST -d postgres -U root -c "create database $PGDB"
psql -h $HOST -d $PGDB -U root -c "create user $PGUSER PASSWORD '$PGUSER'"
psql -h $HOST -d $PGDB -U root -c "ALTER DATABASE $PGDB OWNER TO $PGUSER"
set -e

psql -h $HOST -d postgres -U root -c "grant rds_superuser to $PGUSER; alter user $PGUSER CREATEDB;"
if [ "$(psql -h$HOST -U$PGUSER -tAc "SELECT 1 FROM pg_database WHERE datname='$PGDB'")" = '1' ]
then
    echo "database exists"
    psql -h$HOST -U$PGUSER postgres -t -c "ALTER DATABASE $PGDB OWNER TO $PGUSER;"
    psql -h$HOST -U$PGUSER postgres -t -c "ALTER DATABASE $PGDB CONNECTION LIMIT 0; select pg_terminate_backend(pg_stat_activity.pid) from pg_stat_activity where datname='$PGDB' AND pid <> pg_backend_pid();"
    psql -h$HOST -U$PGUSER postgres -t -c "drop database $PGDB;"
else
    echo "database does not exist"
fi
psql -h $HOST -U$PGUSER postgres -t -c "create database $PGDB;" $HOST $PGUSER $PGDB
#echo "Extracting TOC"
pg_restore -l -f ~/$DUMPPATH/$SERVICE.toc ~/$DUMPPATH/$SERVICE.dump.out
echo "Editing TOC"
sed -i 's/^\(.* COMMENT .*\)/;\1/g' ~/$DUMPPATH/$SERVICE.toc
sed -i 's/^\(.* set session authorization .*\)/;\1/g' ~/$DUMPPATH/$SERVICE.toc
echo "Restoring " $PGDB " To " $HOST ", " $DBSUFFIX
pg_restore -v -O -L ~/$DUMPPATH/$SERVICE.toc -h $HOST -d $PGDB -U $PGUSER ~/$DUMPPATH/$SERVICE.dump.out
#psql -h $HOST -d $PGDB -U $PGUSER -c "INSERT INTO public.users (email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, encrypted_otp_secret, encrypted_otp_secret_iv, encrypted_otp_secret_salt, consumed_timestep) VALUES ('global_admin@gett.com', '\$2a\$10\$TOu6LRFXiVad.dmJd/T4NeMGGAmMSstF2F3xNORjNcR4lkZ1gcrm.', null, null, null, 20, now(),now(), '0.0.0.0', '0.0.0.0', now(), now(), null, null, null, null); INSERT INTO public.users_roles (user_id, role_id) VALUES ((select id from users where email = 'global_admin@gett.com'), (select id from roles where name like '%Global admin' limit 1) );"
}

for srv in   "ru" "us" "uk" "pms" "class-identity" "class-availability" "media" "ordering" "preeta" "clientgateway" "travelpolicy" "trip" "line" "depot" "location" "futureorder" "supplygateway" "saw" "invitation" "osrm" "liveheatmaps" "coupon" "fraud" "charging" "pricing" "subscription" "commission" "reports" "earnings" "rides" "regionidentity" "arm" "notification" "b2bgateway" "victory"; do
    if [[ "$srv" =~ ^(area|bookkeeping)$ ]]; then
        HOST="posgress-qa-ver-95.gtforge.com"
    else
        HOST="posgress-qa.gtforge.com"
    fi
    PGUSER=${srv}${SCRUM}
    PGDB=${PGUSER}
    SERVICE=${srv}
    fake_restore
done