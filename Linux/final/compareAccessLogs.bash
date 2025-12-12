#!/bin/bash

logfile="$1"
iocfile="$2"

if [[ ! -f "$logfile" || ! -f "$iocfile" ]]; then
    echo "Usage: $0 access.log IOC.txt"
    exit 1
fi

> report.txt

while read -r indicator; do
    grep "$indicator" "$logfile" | while read -r line; do
        ip=$(echo "$line" | awk '{print $1}')
        datetime=$(echo "$line" | awk -F'[][]' '{print $2}')
        page=$(echo "$line" | awk '{print $7}')

        echo -e "$ip\t$datetime\t$page" >> report.txt
    done
done < "$iocfile"

echo "Saved matching logs to report.txt"
