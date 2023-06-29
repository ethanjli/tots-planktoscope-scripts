#!/bin/bash -x
ssh_target="pi@planktoscope-regular-level-9927.local"
ssh "$ssh_target" "rm /home/pi/data/import/*.tar.gz"
ssh "$ssh_target" "rm -rf /home/pi/data/clean/* && rm -rf /home/pi/data/objects/* && rm -rf /home/pi/data/img/* && rm -rf /home/pi/data/export/ecotaxa/*"
ssh "$ssh_target" "rm /home/pi/data/results/*-results.tar.gz && rm /home/pi/data/results/*-results-count.txt"
ssh "$ssh_target" "rm \"/home/pi/data/results-preview/*/*-results.tar.gz\""
