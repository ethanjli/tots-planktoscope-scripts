#!/bin/bash -eux
id="$1"
archives_root="/media/pi/Elements/tots-ps/data"
ssh_target="pi@planktoscope-regular-level-9927.local"
ssh "$ssh_target" "mkdir -p /home/pi/data/import"
scp "$archives_root/$id.tar.gz" "$ssh_target:/home/pi/data/import/"
ssh "$ssh_target" "tar -xzf \"/home/pi/data/import/$id.tar.gz\" -C /home/pi/data/img"
ssh "$ssh_target" "rm /home/pi/data/import/$id.tar.gz"
