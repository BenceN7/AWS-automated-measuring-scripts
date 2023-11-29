#!/bin/bash

> results.txt

#szamok beolvasas

mapfile -t execution < execution.txt

# atlag
sum=0
for num in "${execution[@]}"; do
  sum=$(echo "$sum + $num" | bc -l)
done
averagex=$(echo "scale=4; $sum / ${#execution[@]}" | bc -l)

# Szoras
sum_of_squares=0
for num in "${execution[@]}"; do
  diff=$(echo "$num - $averagex" | bc -l)
  squared_diff=$(echo "$diff * $diff" | bc -l)
  sum_of_squares=$(echo "$sum_of_squares + $squared_diff" | bc -l)
done
variance=$(echo "scale=10; $sum_of_squares / ${#execution[@]}" | bc -l)
standard_deviation=$(echo "scale=10; sqrt($variance)" | bc -l)

# beiras fileba

echo "Standard Deviaton: $standard_deviation" >> results.txt

echo "Average Execution time: $averagex" >> results.txt

cpu_info=$(cat /proc/cpuinfo | grep "model name" | uniq)

echo "CPU $cpu_info" >> results.txt

cat results.txt
