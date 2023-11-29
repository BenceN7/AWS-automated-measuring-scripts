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
#echo "$n"
while [ "$n" == "0" ]

do
