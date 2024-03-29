#!/bin/bash

# Stop and remove existing Docker containers
docker-compose down

# Change directory to spark-master
cd spark-master || exit
# Build spark-master image
docker build -t spark-master .

# Change directory to spark-worker
cd ../spark-worker || exit
# Build spark-worker image
docker build -t spark-worker .

# Change back to the main directory
cd ..

# Start Docker containers
docker-compose up
