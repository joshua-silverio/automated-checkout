#!/bin/bash
cards=("0003278380" "0003293374")

for i in "${cards[@]}";
do
    curl -X GET http://localhost:48094/status
    # make sure locks are 1 and door is true

    echo $i
    
    curl -X PUT -H "Content-Type: application/json" -d "{\"card-number\":\"$i\"}" http://localhost:48098/api/v2/device/name/card-reader/card-number
    echo "card read!!!!!!!!!!!!!"
    sleep 5
    curl -X GET http://localhost:48094/status
    # should show lock1_status: 0 (false)
    echo "Card status!!!!!!!!!!!!!"
    # open door
    curl -X PUT -H "Content-Type: application/json" -d '{"setDoorClosed":"0"}' http://localhost:48097/api/v2/device/name/controller-board/setDoorClosed
    echo "open door!!!!!!!!!!!!!"
    sleep 4
    curl -X GET http://localhost:48094/status
    # should show door:false
    echo "open door status!!!!!!!!!!!!!"
    curl -X PUT -H "Content-Type: application/json" -d '{"setDoorClosed":"1"}' http://localhost:48097/api/v2/device/name/controller-board/setDoorClosed
    echo "close door !!!!!!!!!!!!!"
    sleep 4
    curl -X GET http://localhost:48094/status
    # should show door:true
    echo "close door status!!!!!!!!!!!!!"
    curl -X GET http://localhost:48095/inventory
    echo "Get inventory !!!!!!!!!!!!!"
    curl -X GET http://localhost:48095/auditlog
    echo "Get Audit log!!!!!!!!!!!!!"
    curl -X GET http://localhost:48093/ledger
    echo "Get ledger!!!!!!!!!!!!!"
    sleep 30
done