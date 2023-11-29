#!/bin/bash

> results.txt

echo "ilyen txt fajbol olvas:"

read user_input

#szamok beolvasasa
readarray -t numbers < $user_input

# atlag
sum=0
for num in "${numbers[@]}"; do
  sum=$(echo "$sum + $num" | bc -l)
done
average=$(echo "scale=4; $sum / ${#numbers[@]}" | bc -l)

# Szoras
sum_of_squares=0
for num in "${numbers[@]}"; do
  diff=$(echo "$num - $average" | bc -l)
  sum_of_squares=$(echo "$sum_of_squares + ($diff * $diff)" | bc -l)
done
variance=$(echo "scale=4; $sum_of_squares / ${#numbers[@]}" | bc -l)
standard_deviation=$(echo "scale=7; sqrt($variance)" | bc -l)

echo "Average: $average" >> results.txt
echo "Standard Deviaton: $standard_deviation" >> results.txt

cat results.txt
