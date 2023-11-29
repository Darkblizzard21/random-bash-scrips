#!/bin/bash
# Copyright (c) 2023 Pirmin Pfeifer

# explane usage
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 domain [path]"
    exit 1
fi

domain="$1"
if [[ "$domain" == "https://"* ]]; then
    echo "$domain"
    domain=${domain:8:${#domain}}
fi
if [[ "$domain" == "http://"* ]]; then
    domain=${domain:7:${#domain}}
fi
if [[ "${domain: -1}" == "/" ]]; then
    domain=${domain:0:${#domain}-1}
fi

if [ "$#" -eq 2 ]; then
    domain=$domain/$2
fi
webpage_content=$(curl -s "https://$domain")
urls=$(echo "$webpage_content" |  grep -Eo "(http|https)://[a-zA-Z0-9#~.*,/!?=+&_%:-]*")
echo "${urls}"
