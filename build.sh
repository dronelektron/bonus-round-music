#!/bin/bash

PLUGIN_NAME="bonus-round-music"

cd scripting
spcomp $PLUGIN_NAME.sp -i include -o ../plugins/$PLUGIN_NAME.smx
