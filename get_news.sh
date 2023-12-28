#!/bin/bash
API_TOKEN='<Add Here Your API Key>'
# Make a request to get updates (messages) from the bot
response=$(curl -s "https://api.telegram.org/bot$API_TOKEN/getUpdates")
API_KEY="f9a8cdf6ba5a4becab5cfd5b70c59448"
API_URL="https://newsapi.org/v2/top-headlines"
# Check if the latest message contains "us"
latest_message=$(echo "$response" | jq -r '.result[-1].message.text')
# Set default values
COUNTRY_CODE=''
UNKNOWN_PATTERN_MSG='Unknown pattern.'
# Check the latest message and set the country code accordingly
if [[ $latest_message == *"us"* ]]; then
    COUNTRY_CODE='us'
elif [[ $latest_message == *"ar"* ]]; then
    COUNTRY_CODE='ar'
elif [[ $latest_message == *"au"* ]]; then
    COUNTRY_CODE='au'
elif [[ $latest_message == *"br"* ]]; then
    COUNTRY_CODE='br'
elif [[ $latest_message == *"eg"* ]]; then
    COUNTRY_CODE='eg'
elif [[ $latest_message == *"tr"* ]]; then
    COUNTRY_CODE='tr'
elif [[ $latest_message == *"ae"* ]]; then
    COUNTRY_CODE='ae'
else
    echo "$UNKNOWN_PATTERN_MSG"
    exit 1
fi

# Fetch and display the latest news based on the selected country
if [ -n "$COUNTRY_CODE" ]; then
    curl -s "$API_URL?country=$COUNTRY_CODE&apiKey=$API_KEY" | jq .
else
    echo "$UNKNOWN_PATTERN_MSG"
fi
