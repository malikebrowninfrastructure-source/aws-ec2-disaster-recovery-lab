#!/bin/bash

# Create application data structure

sudo mkdir -p /app-data/config
sudo mkdir -p /app-data/logs

echo "Disaster Recovery Test File" | sudo tee /app-data/testfile.txt

echo "Application data created successfully."
