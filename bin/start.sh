#!/bin/bash
redis-server --daemonize yes --bind 127.0.0.1
./bin/rails server
