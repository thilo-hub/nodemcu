#!/bin/sh
NODE=$1
FILE=$2

MQ="ts2.nispuk.com"

CHANNEL=node

mosquitto_pub -h $MQ -t $CHANNEL -m "$NODE open $FILE"
base64 < $FILE |
  while read F; do
	mosquitto_pub -h $MQ -t $CHANNEL -m "$NODE bwrite $F"
  done
mosquitto_pub -h $MQ -t $CHANNEL -m "$NODE close"
if [ X"$3" = X"start" ]; then
	mosquitto_pub -h $MQ -t $CHANNEL -m "$NODE dofile $FILE"
fi

     

