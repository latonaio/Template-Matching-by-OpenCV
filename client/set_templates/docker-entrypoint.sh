#!/bin/bash

# wait for template-matching-server
/bin/sh -c "sleep 10"

python3 -u main.py
/bin/sh -c "sleep 3"
curl -s -X POST localhost:10001/quitquitquit