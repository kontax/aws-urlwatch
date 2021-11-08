#!/bin/sh
#
# Update the urlwatch config with email secrets from environment variables
# and run urlwatch
#

set -euo pipefail

echo "$ whoami"
whoami

echo "$ cat /etc/passwd"
cat /etc/passwd

echo "$ mount"
mount

echo "$ ls /home/urlwatch"
ls -al /home/urlwatch

echo "$ ls /home/urlwatch/.urlwatch"
ls -al /home/urlwatch/.urlwatch

echo "$ ls /"
ls -al /

echo "[*] Checking environment variables have been set correctly"

if [[ -z "${UW_HOST}" ]]; then
    echo -e "The urlwatch SMTP host needs to be set in the UW_HOST env var"
    exit 1
fi

if [[ -z "${UW_PORT}" ]]; then
    echo -e "The urlwatch SMTP port needs to be set in the UW_PORT env var"
    exit 1
fi

if [[ -z "${UW_USER}" ]]; then
    echo -e "The urlwatch SMTP user needs to be set in the UW_USER env var"
    exit 1
fi

if [[ -z "${UW_PASS}" ]]; then
    echo -e "The urlwatch SMTP password needs to be set in the UW_PASS env var"
    exit 1
fi

if [[ -z "${UW_FROM}" ]]; then
    echo -e "The urlwatch SMTP sender needs to be set in the UW_FROM env var"
    exit 1
fi

if [[ -z "${UW_RCPT}" ]]; then
    echo -e "The urlwatch SMTP recipient needs to be set in the UW_RCPT env var"
    exit 1
fi

echo "[*] Looking for the urlwatch.yaml config file"

if [ ! -f /home/urlwatch/urlwatch.yaml ]; then
    echo -e "The urlwatch.yaml config file does not exist"
    exit 1
fi

echo "[*] Updating config file with environment variables"

sed -i "s/#UW_HOST#/$UW_HOST/g" /home/urlwatch/urlwatch.yaml
sed -i "s/#UW_PORT#/$UW_PORT/g" /home/urlwatch/urlwatch.yaml
sed -i "s/#UW_USER#/$UW_USER/g" /home/urlwatch/urlwatch.yaml
sed -i "s/#UW_PASS#/$UW_PASS/g" /home/urlwatch/urlwatch.yaml
sed -i "s/#UW_FROM#/$UW_FROM/g" /home/urlwatch/urlwatch.yaml
sed -i "s/#UW_RCPT#/$UW_RCPT/g" /home/urlwatch/urlwatch.yaml

echo "[*] Running urlwatch"
urlwatch \
    --cache /home/urlwatch/.urlwatch/urlwatch.db \
    --config /home/urlwatch/urlwatch.yaml \
    --urls /home/urlwatch/urls.yaml
