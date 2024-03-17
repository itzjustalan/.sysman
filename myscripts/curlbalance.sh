#!/bin/sh

#ASIANET_SUB_CODE='KT66353'

echo "curl 'https://myabb.in/totalBalance' --data-raw subscriberCode=$ASIANET_SUB_CODE"
LC_resp=$(curl 'https://myabb.in/totalBalance' --data-raw "subscriberCode=$ASIANET_SUB_CODE")

LC_resp=$(echo "$LC_resp" | tr ',' '\n')
LC_connType=$(echo "$LC_resp" | grep "connType" | cut -d',' -f4 | cut -d'"' -f4)
LC_usage=$(echo "$LC_resp" | grep "totalOctets" | cut -d':' -f2)
LC_total_total=$(echo "$LC_usage" | cut -d'.' -f1 | sed -n '2 p')
LC_total_left=$(echo "$LC_usage" | cut -d'.' -f1 | sed -n '1 p')
LC_total_used=$(echo "$LC_usage" | cut -d'.' -f1 | sed -n '3 p')

LC_pretty_out="$ASIANET_SUB_CODE $LC_connType CONN
TOTAL: $(echo "scale=2;$LC_total_total/1024" | bc -l) GiB
LEFT: $(echo "scale=2;$LC_total_left/1024" | bc -l) GiB
USED: $(echo "scale=2;$LC_total_used/1024" | bc -l) GiB"
#echo "$LC_pretty_out"
notify-send "$LC_pretty_out"
