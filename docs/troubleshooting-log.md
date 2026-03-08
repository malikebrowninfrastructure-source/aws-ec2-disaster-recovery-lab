# Troubleshooting Log

This document records errors encountered during the disaster recovery lab and the steps taken to diagnose and resolve them.

Documenting troubleshooting steps is important for improving operational procedures and building reliable recovery runbooks.

---

# Issue 1: Terraform Snapshot Restore Configuration Error

## Problem

Terraform returned the following error when attempting to restore the snapshot:
Unsupported argument
snapshot_id is not expected here

## Root Cause

The `snapshot_id` argument was incorrectly placed directly inside the `aws_instance` resource.

Terraform does not allow the root volume of an EC2 instance to be restored from a snapshot using the `aws_instance` resource.

## Resolution

The recovery architecture was modified to follow the correct AWS pattern:

1. Launch a new EC2 instance
2. Create an EBS volume from the snapshot
3. Attach the restored volume to the instance

Terraform resources used:
aws_ebs_volume
aws_volume_attachment

---

# Issue 2: Terraform Lifecycle Manager Configuration Error

## Problem

Terraform returned the following error when creating the automated snapshot policy:
Unsupported block type
Blocks of type “schedules” are not expected here.
Did you mean “schedule”?

## Root Cause

The Terraform configuration used an incorrect block name.

The AWS provider expects the block to be named:
schedule
## Resolution

The block name was corrected from:
schedules

Terraform validation succeeded after the change.

---

# Issue 3: Restored Volume Mount Failure

## Problem

Attempting to mount the restored EBS volume produced the following error:
wrong fs type, bad option, bad superblock
## Investigation

The block devices were inspected using:
lsblk -f
The restored volume contained an XFS filesystem.

---

# Root Cause

The restored disk was a clone of the original root volume and retained the same filesystem UUID.

Linux prevents mounting two XFS filesystems with identical UUID values simultaneously.

---

# Resolution

The filesystem was mounted using the `nouuid` option:
sudo mount -o nouuid /dev/nvme1n1p1 /mnt/recovery

This bypassed the UUID conflict and allowed the filesystem to mount successfully.

Recovered application data was verified after mounting.

---



