#!/bin/bash


KSAR_PATH="/home/mleal/Otros/kSar/ksar-5.2.4-SNAPSHOT-all.jar"
MULTIPLE="/home/mleal/Otros/kSar/kSar-5.0.6/kSar.jar"
FILE=$1

if [ -z $1  ] || [ -z $2  ]; then
    java -jar $KSAR_PATH -input $FILE -tile cpuFixedAxis
else
    java -jar $MULTIPLE -input $1 -input $2
fi
