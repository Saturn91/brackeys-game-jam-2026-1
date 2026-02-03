#!/bin/bash

start http://localhost:8000/

# Start a local HTTP server using Python, serving from the builds/web directory
python -m http.server 8000 --directory builds/web

