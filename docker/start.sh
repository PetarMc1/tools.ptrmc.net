#!/bin/sh

# Start the backend servers in the background
node /app/gitrss/backend/dist/index.js &
node /app/package-json-analyzer/backend/dist/server.js &
node /app/openapi-merger/backend/dist/backend/src/index.js &

nginx -g 'daemon off;' &

# Wait for background processes
wait