#!/bin/bash

# If we are in the .scripts folder, move up one level
if [ "$(basename "$PWD")" == ".scripts" ]; then
  cd ..
fi

# If we are not in the root folder, exit
if [ ! -f "project.godot" ]; then
  echo "Error: You must run this script from the root folder of the project."
  exit 1
fi

# Create the builds sub-folders if they don't exist yet
mkdir -p builds/web
mkdir -p builds/linux
mkdir -p builds/win
mkdir -p builds/macos



