#!/bin/bash

load=$(curl "https://localhost:443/app/loadavg" -k)
if [ $(echo "$load >= 0.00" | bc) -ne 0 ] && [ $(echo "$load < 0.05" | bc) -ne 0 ]; then
    echo "OK - Load Average is $load"
    exit 0
elif [ $(echo "$load >= 0.05" | bc) -ne 0 ] && [ $(echo "$load < 0.1" | bc) -ne 0 ]; then
    echo "WARNING - Load Average is $load" 
    exit 1
elif [ $(echo "$load >= 0.1" | bc) -ne 0 ]; then
    echo "CRITICAL - Load Average is $load"
    exit 2
fi

