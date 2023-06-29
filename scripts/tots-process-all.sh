#!/bin/bash
echo "Cleaning up..."
tots-clean.sh
while true; do
  next_dataset=$(tots-next-unprocessed-dataset.sh)
  if [ -z "$next_dataset" ]; then
    sleep 60
    continue
  fi
  echo "Processing dataset $next_dataset..."
  tots-process-remotely.sh "$next_dataset"
  echo "Done processing dataset $next_dataset! Waiting for 30 seconds to proceed (press Ctrl+C to quit)..."
  sleep 30
done
