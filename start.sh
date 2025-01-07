#!/bin/sh

# Activate Python virtual environment and start the API in the background
. /home/node/.n8n/python/venv/bin/activate && \
python3 -m uvicorn src.api_server:app --host 0.0.0.0 --port 8000 &

# Start n8n in the foreground
n8n start
