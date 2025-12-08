#!/bin/bash

URL="http://localhost/Assignment.html"

page=$(curl -s "$URL")

temps=$(echo "$page" | grep -A5 "The Temprature Read" | grep "<td>" | awk -F'[<>]' '/<td>/{print $3}')

pressures=$(echo "$page" | grep -A5 "The Pressure Read" | grep "<td>" | awk -F'[<>]' '/<td>/{print $3}')

datetimes=$(echo "$page" | grep "<td>" | grep "/" | awk -F'[<>]' '{print $3}')

count=$(echo "$temps" | wc -l)

echo "Temperature  Pressure  Date-Time"
echo "-------------------------------------------"

for i in $(seq 1 $count); do
    t=$(echo "$temps" | head -n $i | tail -n 1)
    p=$(echo "$pressures" | head -n $i | tail -n 1)
    d=$(echo "$datetimes" | head -n $i | tail -n 1)
    echo "$t           $p        $d"
done
