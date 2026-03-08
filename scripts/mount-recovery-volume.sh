#!/bin/bash

echo "Mounting recovered EBS volume..."

sudo mkdir -p /mnt/recovery
sudo mount -o nouuid /dev/nvme1n1p1 /mnt/recovery

echo "Volume mounted at /mnt/recovery"
