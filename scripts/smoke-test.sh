#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../terraform"
url="$(terraform output -raw web_url)"
echo "Checking $url (EC2 bootstrap may take a few minutes)"
for attempt in {1..24}; do
  if curl --fail --silent --show-error --max-time 8 "$url" | grep -q 'Infrastructure provisioned with Terraform'; then
    echo "PASS: Nginx demo is responding"
    exit 0
  fi
  sleep 10
done
echo "FAIL: service did not become healthy within 4 minutes" >&2
exit 1
