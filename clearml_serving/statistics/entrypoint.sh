#!/bin/bash

# print configuration
echo CLEARML_SERVING_TASK_ID="$CLEARML_SERVING_TASK_ID"
echo CLEARML_SERVING_PORT="$CLEARML_SERVING_PORT"
echo EXTRA_PYTHON_PACKAGES="$EXTRA_PYTHON_PACKAGES"
echo CLEARML_SERVING_POLL_FREQ="$CLEARML_SERVING_POLL_FREQ"
echo CLEARML_DEFAULT_KAFKA_SERVE_URL="$CLEARML_DEFAULT_KAFKA_SERVE_URL"

SERVING_PORT="${CLEARML_SERVING_PORT:-9999}"

# set default internal serve endpoint (for request pipelining)
CLEARML_DEFAULT_BASE_SERVE_URL="${CLEARML_DEFAULT_BASE_SERVE_URL:-http://127.0.0.1:$SERVING_PORT/serve}"
CLEARML_DEFAULT_TRITON_GRPC_ADDR="${CLEARML_DEFAULT_TRITON_GRPC_ADDR:-127.0.0.1:8001}"

# print configuration
echo SERVING_PORT="$SERVING_PORT"

# runtime add extra python packages
if [ ! -z "$EXTRA_PYTHON_PACKAGES" ]
then
      python3 -m pip install $EXTRA_PYTHON_PACKAGES
fi

echo "Starting Statistics Controller server"
PYTHONPATH=$(pwd) python3 clearml_serving/statistics/main.py