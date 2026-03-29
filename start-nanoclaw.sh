#!/bin/bash
# start-nanoclaw.sh — Start NanoClaw without systemd
# To stop: kill \$(cat /Users/dopio/nanoclaw/nanoclaw.pid)

set -euo pipefail

cd "/Users/dopio/nanoclaw"

# Stop existing instance if running
if [ -f "/Users/dopio/nanoclaw/nanoclaw.pid" ]; then
  OLD_PID=$(cat "/Users/dopio/nanoclaw/nanoclaw.pid" 2>/dev/null || echo "")
  if [ -n "$OLD_PID" ] && kill -0 "$OLD_PID" 2>/dev/null; then
    echo "Stopping existing NanoClaw (PID $OLD_PID)..."
    kill "$OLD_PID" 2>/dev/null || true
    sleep 2
  fi
fi

echo "Starting NanoClaw..."
nohup "/opt/homebrew/bin/node" "/Users/dopio/nanoclaw/dist/index.js" \
  >> "/Users/dopio/nanoclaw/logs/nanoclaw.log" \
  2>> "/Users/dopio/nanoclaw/logs/nanoclaw.error.log" &

echo $! > "/Users/dopio/nanoclaw/nanoclaw.pid"
echo "NanoClaw started (PID $!)"
echo "Logs: tail -f /Users/dopio/nanoclaw/logs/nanoclaw.log"
