#!/bin/bash

WOEID=123456
ICONSPATH="./weathericons"

curl -s "http://weather.yahooapis.com/forecastrss?w=$WOEID&u=c" -o ~/.cache/weather.xml

CITY=$(grep "yweather:location" ~/.cache/weather.xml | cut -d \" -f 2)
UPDATED=$(grep "yweather:condition" ~/.cache/weather.xml | cut -d \" -f 8 | cut -d " " -f5,6)
TEMP=$(grep "yweather:condition" ~/.cache/weather.xml | cut -d \" -f 6)
CODE=$(grep "yweather:condition" ~/.cache/weather.xml | cut -d \" -f 4)
COND=$(grep "yweather:condition" ~/.cache/weather.xml | cut -d \" -f 2)
SPEED=$(grep "yweather:wind" ~/.cache/weather.xml | cut -d \" -f 6)
S_UNIT=$(grep "yweather:units" ~/.cache/weather.xml | cut -d \" -f 8)
CODE_TOD=$(grep "yweather:forecast" ~/.cache/weather.xml | cut -d \" -f 12 | head -n 1)
CODE_TOM=$(grep "yweather:forecast" ~/.cache/weather.xml | cut -d \" -f 12 | head -n 2 | tail -n 1)
TOD=$(grep "yweather:forecast" ~/.cache/weather.xml | cut -d \" -f 2 | head -n 1)
TOM=$(grep "yweather:forecast" ~/.cache/weather.xml | cut -d \" -f 2 | head -n 2 | tail -n 1)
HI_TOD=$(grep "yweather:forecast" ~/.cache/weather.xml | cut -d\" -f 8 | head -n1)
HI_TOM=$(grep "yweather:forecast" ~/.cache/weather.xml | cut -d\" -f 8 | head -n 2 | tail -n 1)
LOW_TOD=$(grep "yweather:forecast" ~/.cache/weather.xml | cut -d\" -f 6 | head -n1)
LOW_TOM=$(grep "yweather:forecast" ~/.cache/weather.xml | cut -d\" -f 6 | head -n 2 | tail -n 1)

FORECASTS="$CITY:$TEMP:$COND:$SPEED:$S_UNIT:$TOD:$TOM:$HI_TOD:$LOW_TOD:$HI_TOM:$LOW_TOM:$UPDATED"

cp -f $ICONSPATH/$CODE_TOD.png ~/.cache/weather-today.png
cp -f $ICONSPATH/$CODE_TOM.png ~/.cache/weather-tomorrow.png
cp -f $ICONSPATH/$CODE.png ~/.cache/weather.png

notify-send -i ~/.cache/weather.png  "$(echo -e " $CITY\n\t $TEMP° - $COND")"
echo $FORECASTS > ~/.cache/forecasts
