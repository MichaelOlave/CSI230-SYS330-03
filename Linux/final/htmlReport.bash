#!/bin/bash

report="report.txt"
output="report.html"

if [[ ! -f "$report" ]]; then
    echo "report.txt not found"
    exit 1
fi

echo "<html>" > "$output"
echo "<body>" >> "$output"
echo "<h2>Access logs with IOC indicators:</h2>" >> "$output"
echo "<table border='1'>" >> "$output"

while IFS=$'\t' read -r ip datetime page; do
    echo "<tr><td>$ip</td><td>$datetime</td><td>$page</td></tr>" >> "$output"
done < "$report"

echo "</table>" >> "$output"
echo "</body>" >> "$output"
echo "</html>" >> "$output"

sudo mv "$output" /var/www/html/report.html

echo "HTML report available at http://localhost/report.html"
