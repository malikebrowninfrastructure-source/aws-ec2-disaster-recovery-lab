#!/bin/bash

echo "Checking recovered application data..."

ls /mnt/recovery/app-data

echo "Contents of test file:"
cat /mnt/recovery/app-data/testfile.txt
