#!/bin/bash
./prometheus/prometheus --config.file=/prometheus/config.yml &
service grafana-server start &
./app/app
wait