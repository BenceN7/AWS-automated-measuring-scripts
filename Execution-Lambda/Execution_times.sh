#!/bin/bash

echo "Mi a function neve?:"

read user_input

> execution.txt

for i in {1..100}
do

date +%s > date.txt && aws lambda invoke --function-name $user_input --cli-binary-format raw-in-base64-out --payload fileb://i>
date=$(cat date.txt)

execution_time=$(cat output.json | jq -r '.execution_time')

echo "$execution_time" >> execution.txt

difference=$(echo "$start_time - $date" | bc)

done

exec ./results.sh
