#!/usr/bin/env bash

if pgrep -x hyprsunset > /dev/null; then
    # Если hyprsunset запущен — выключаем
    pkill hyprsunset
    notify-send "Night Light" "Disabled" -i weather-clear
else
    # Если не запущен — включаем
    hyprsunset -t 3700 &
    notify-send "Night Light" "Enabled (3700K)" -i weather-clear-night
fi
