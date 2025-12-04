#!/bin/bash

authfile="/var/log/auth.log"

function getLogins() {
    grep "New session '" "$authfile" | awk '{print $1, $2, $3, $NF}'
}

function getFailedLogins() {
    grep -E "authentication failure|password check failed" "$authfile" | awk '{print $1, $2, $3, $NF}'
}

echo "To: michael.olave@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
echo "" >> emailform.txt
getLogins >> emailform.txt
cat emailform.txt | /usr/sbin/ssmtp michael.olave@mymail.champlain.edu

echo "To: michael.olave@mymail.champlain.edu" > failed_email.txt
echo "Subject: Failed Logins" >> failed_email.txt
echo "" >> failed_email.txt
getFailedLogins >> failed_email.txt
cat failed_email.txt | /usr/sbin/ssmtp michael.olave@mymail.champlain.edu

