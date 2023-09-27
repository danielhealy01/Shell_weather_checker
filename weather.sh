#!/bin/bash

source .ENV
# source imports environement variables

get_weather() {
    CITY="london"
    API_URL="https://api.openweathermap.org/data/2.5/weather?q=$CITY&appid=$API_KEY&units=metric"
    response=$(curl -s "$API_URL")
    # -s flag for curl is silent / quiet mode. Not verbose on request progress
    # $? shell variable for recent error / status code. Checking success.
    # jq -r is range limiting flag. limit to certain json K:V pair.
    if [[ $? -eq 0 ]]; then

        temperature=$(echo "$response" | jq -r '.main.temp')
        description=$(echo "$response" | jq -r '.weather[0].description')

        echo "Today's weather in $CITY:"
        echo "Temperature: ${temperature}°C"
        # variable wraped in {} if there is characters either side, to delimit where var name stops
        echo "description: $description"
    else
        echo "Failed to retrieve weather."
    fi
}

get_weather