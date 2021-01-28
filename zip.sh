#!/bin/bash

if [ -d "dist" ]; then
  cd ./dist
  zip -r -y ../libiconv.zip .
  cd ..
fi
