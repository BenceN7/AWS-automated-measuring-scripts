#!/bin/bash

echo "Mi a cluster neve?:"
read cluster

echo "es mi az ARN?:"
read ARN

for i in {1..50}
do

aws ecs list-tasks --cluster $cluster --region us-east-1 > tasks.json

task=$(cat tasks.json | jq '.taskArns[]')
task=$(echo "${task:1:${#task}-2}")

date +%s > date.txt && aws ecs stop-task --cluster $ARN --task "$task" --region us-east-1

Signal_time=$(cat date.txt)

n="0"

while [ "$n" == "0" ]

do

aws dynamodb get-item --region us-east-1 --table-name ECSTest --key '{"Started": {"N": "0"}}' > output.json

n=$(cat output.json | jq '.Item.TimeStamp.N|tonumber')

done

date +%s > date.txt

Restart_time=$(cat date.txt)
aws dynamodb update-item --region us-east-1 --table-name ECSTest --key '{"Started": {"N": "0"}}'  --update-expression "SET #Ts$

difference=$(echo "$Restart_time - $Signal_time" | bc)

echo "$difference" >> cold_start.txt

done
