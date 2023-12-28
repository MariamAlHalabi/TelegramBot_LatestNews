#!/bin/bash
API_TOKEN='6583163605:AAGynAGHrh13pjGgFBzH3zq0mmDsrOYvXwI'
USER_CHAT_ID='6450340659'
MESSAGE_TEXT=$(./get_news.sh)

# Check if the message length exceeds the limit
max_length=4096
if [ ${#MESSAGE_TEXT} -gt $max_length ]; then
    # Truncate the message if it's too long
    MESSAGE_TEXT="${MESSAGE_TEXT:0:$max_length}"
fi

url="https://api.telegram.org/bot$API_TOKEN/sendMessage"
data="chat_id=$USER_CHAT_ID&text=$MESSAGE_TEXT"

response=$(curl -s -X POST "$url" -d "$data")

if [[ $(jq -r '.ok' <<< "$response") == "true" ]]; then
    echo 'Message sent successfully!'
else
    error_message=$(jq -r '.description' <<< "$response")
    echo "Error sending message. Response: $error_message"
fi

