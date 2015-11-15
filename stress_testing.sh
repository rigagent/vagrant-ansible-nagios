#!/bin/bash

# Run the Locust hatch
if [ $# -eq 0 ]; then
    locust -H https://localhost:4444 --clients=100 --hatch-rate=5 --no-web
else
    locust -H https://localhost:4444 --clients=$1 --hatch-rate=$2 --no-web
fi
