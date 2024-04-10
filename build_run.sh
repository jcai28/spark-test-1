#!/bin/bash

# Stop and remove existing Docker containers
docker-compose down

# Change directory to spark-master
cd spark || exit
# Build spark-master image
docker build -t spark-image .

# Change back to the main directory
cd ..

# Start Docker containers
docker-compose up
