#!/bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs() {
    allLogs=$(cat "$file" | cut -d' ' -f1,7 | tr -d '[/')
}

function countPageAccesses() {
    getAllLogs
    echo "Page Access Counts:"
    echo "$allLogs" | sort | uniq -c | sort -nr
}

function countCurlCalls() {
    getAllLogs
    local count
    count=$(echo "$allLogs" | grep -i 'curl' | wc -l)
    echo "Curl call count: $count"
}

function countingCurlAccess() {
    local hits total_requests unique_ips
    hits=$(grep -i 'curl' "$file" 2>/dev/null | awk '{print $1}' | sort | uniq -c | sort -nr)
    total_requests=$(grep -i 'curl' "$file" 2>/dev/null | wc -l)
    unique_ips=$(grep -i 'curl' "$file" 2>/dev/null | awk '{print $1}' | sort -u | wc -l)

    echo "Curl accesses by IP:"
    if [[ -z "$hits" ]]; then
        echo "No curl accesses found."
        return
    fi
    echo "$hits"
    echo "Total curl requests: $total_requests"
    echo "Unique IPs making curl requests: $unique_ips"
}

countingCurlAccess