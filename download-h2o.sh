#!/bin/bash

H2O="h2o-3.16.0.2"
H2O_ZIP="$H2O.zip"
H2O_URL="http://h2o-release.s3.amazonaws.com/h2o/rel-wheeler/2/$H2O_ZIP"

BIN="./bin"
MODEL_PATH="$BIN/DRF_model_R_1519552472385_2"

# Download and unzip H20

if [ ! -f $BIN/$H2O_ZIP ]; then
    wget -P $BIN "$H2O_URL" --show-progress > /dev/null
fi

if [ ! -d $BIN/$H2O/ ]; then
    unzip "$BIN/$H2O_ZIP" -d "$BIN/"
fi

# Run h2o in the background and upload the model to it

java -jar $BIN/$H2O/h2o.jar &>/dev/null &

# Wait for h2o to start up...

curl -X POST "http://localhost:54321/99/Models.bin/not_in_use" --data "dir=$MODEL_PATH" --retry 5 --retry-connrefused --retry-delay 5

