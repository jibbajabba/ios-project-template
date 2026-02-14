#!/bin/bash

# Reliable Expo iOS development startup script
# Usage: ./start-dev.sh
# Press Ctrl+C to stop Metro when done

# Force Metro to use localhost
export REACT_NATIVE_PACKAGER_HOSTNAME=127.0.0.1

# Cleanup function
cleanup() {
    echo ""
    echo "Stopping Metro..."
    kill $METRO_PID 2>/dev/null
    exit 0
}
trap cleanup SIGINT SIGTERM

# Kill any existing Metro processes
pkill -f "expo start" 2>/dev/null
sleep 1

echo "Starting Metro bundler..."

# Start Metro in the background, redirect output to a log file
npx expo start --localhost > /tmp/metro.log 2>&1 &
METRO_PID=$!

echo "Metro PID: $METRO_PID"
echo "Waiting for Metro status endpoint..."

# Wait for Metro status endpoint to respond
MAX_WAIT=60
WAITED=0

while true; do
    if ! kill -0 $METRO_PID 2>/dev/null; then
        echo "Metro process died. Check /tmp/metro.log"
        tail -20 /tmp/metro.log
        exit 1
    fi

    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://127.0.0.1:8081/status" 2>/dev/null)
    if [ "$STATUS" = "200" ]; then
        break
    fi

    sleep 1
    WAITED=$((WAITED + 1))
    if [ $WAITED -ge $MAX_WAIT ]; then
        echo "Timed out waiting for Metro status"
        exit 1
    fi
done

echo "Metro is up. Pre-warming the iOS bundle (this may take a minute)..."

# Pre-warm the bundle by requesting it
BUNDLE_URL="http://127.0.0.1:8081/node_modules/expo-router/entry.bundle?platform=ios&dev=true&hot=false&lazy=true"

MAX_WAIT=180
WAITED=0

while true; do
    if ! kill -0 $METRO_PID 2>/dev/null; then
        echo "Metro process died during bundling"
        tail -30 /tmp/metro.log
        exit 1
    fi

    # Try to fetch the bundle (with timeout)
    BUNDLE_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$BUNDLE_URL" 2>/dev/null)

    if [ "$BUNDLE_STATUS" = "200" ]; then
        echo "Bundle is ready!"
        break
    fi

    sleep 2
    WAITED=$((WAITED + 2))

    if [ $WAITED -ge $MAX_WAIT ]; then
        echo "Timed out waiting for bundle to compile"
        tail -30 /tmp/metro.log
        exit 1
    fi

    # Show progress from metro log
    PROGRESS=$(tail -1 /tmp/metro.log 2>/dev/null | grep -o '[0-9.]*%' | tail -1)
    echo "Bundling... ${PROGRESS:-starting} ($WAITED s)"
done

echo "Launching iOS app..."
npx expo run:ios --no-bundler

echo ""
echo "================================================"
echo "App launched! Metro is running in the background."
echo "Press Ctrl+C to stop Metro when you're done."
echo "================================================"

# Keep script running to maintain Metro
tail -f /tmp/metro.log
