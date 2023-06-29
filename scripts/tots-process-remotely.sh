#!/bin/bash -eux
id="$1"
mqtt_api="planktoscope-regular-level-9927.local"
tots-upload-frames.sh "$1"
planktoscope dev --api mqtt://$(getent ahosts "$mqtt_api" | awk '{ print $1; exit }'):1883 proc start
tots-download-results.sh "$1"
