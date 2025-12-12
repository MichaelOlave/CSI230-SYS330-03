#!/bin/bash

url="http://localhost/IOC.html"

page=$(curl -s "$url")

echo "$page" | \
    grep -oP '(?<=<td>).*?(?=</td>)' > IOC.txt

echo "Saved IOC indicators to IOC.txt"
