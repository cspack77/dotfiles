#!/usr/bin/env bash

LOCID="4168062"
APIKEY="b431310fbc57be52b95d23abf9545f81"
URL="api.openweathermap.org/data/2.5/weather?id=$LOCID&appid=$APIKEY&units=imperial"
SITE="$(wget -q -O - "$URL")"

weather="$(echo "$SITE" | jq .weather[0].main)"
temp="$(echo "$SITE" | jq .main.temp | xargs printf '%.*f' 0)"

if [[ $weather == *[Tt]hunder* ]]; then
    icon=" "
elif [[ $weather == *[Rr]ain* ]]; then
    icon=""
elif [[ $weather == *[Ss]now* ]]; then
    icon=""
elif [[ $weather == *[Cc]loud* ]]; then
    icon=""
else
    icon=""
fi

# Does not display if there's not temperature to display
if [ ! -z $temp ]; then
    text="$icon $temp°"
    echo "$text"
fi
