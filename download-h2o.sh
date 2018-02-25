#!/bin/bash

H2O="h2o-3.16.0.2"
H2O_ZIP="$H2O.zip"
H2O_URL="http://h2o-release.s3.amazonaws.com/h2o/rel-wheeler/2/$H2O_ZIP"

MODEL_PATH="../DRF_model_R_1519552472385_2"

# Download and unzip H20

if [ ! -f ./$H2O_ZIP ]; then
    wget "$H2O_URL" --show-progress > /dev/null
    unzip "./$H2O_ZIP"
fi

# Run h2o in the background and upload the model to it

java -jar ./$H2O/h2o.jar &>/dev/null &

# Wait for h2o to start up...

sleep 5

curl -X POST "http://localhost:54321/99/Models.bin/not_in_use" --data "dir=$MODEL_PATH"

