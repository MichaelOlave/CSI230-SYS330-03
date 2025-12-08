#!/bin/bash

link="http://localhost/Courses.html"

fullPage=$(curl -sL "$link")

if [ -z "$fullPage" ]; then
    echo "Error: curl returned no data from $link"
    exit 1
fi

echo "$fullPage" | \
xmlstarlet sel --html --recover \
    -t -m "//table[@id='grid']//tr" \
    -m "th|td" -v "normalize-space(.)" -o ";" -b \
    -n \
| sed 's/;$//' \
| sed '/^$/d' \
> courses.txt