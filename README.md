# AWS EC2 Disaster Recovery Lab

## Overview

This project demonstrates a disaster recovery workflow in AWS using Terraform, Amazon EC2, Amazon EBS snapshots, AWS Systems Manager Session Manager, and AWS Data Lifecycle Manager.

The lab simulates a real-world failure scenario in which an EC2 instance is deployed, application data is written to disk, a snapshot backup is created, the server is destroyed, and the data is restored to a new instance from the snapshot.

## Objectives

- Deploy AWS infrastructure using Terraform
- Access EC2 securely using Systems Manager Session Manager instead of SSH
- Create and verify application data on an EBS-backed EC2 instance
- Create and restore EBS snapshots
- Simulate infrastructure loss and recovery
- Implement automated snapshot backups using AWS Data Lifecycle Manager
- Document recovery steps, issues, and lessons learned

## Technologies Used

- AWS EC2
- AWS EBS
- AWS Systems Manager Session Manager
- AWS Data Lifecycle Manager (DLM)
- Terraform
- Amazon Linux 2023
- Linux filesystem and disk recovery commands

## Architecture Summary

The environment consists of:

- A Terraform-managed EC2 instance
- An encrypted gp3 EBS root volume
- IAM role and instance profile for Systems Manager access
- A restored EBS volume created from a snapshot
- An automated DLM policy for scheduled snapshot backups

## Recovery Scenario

1. Deploy EC2 infrastructure with Terraform
2. Connect to the instance using SSM Session Manager
3. Create application data under `/app-data`
4. Create an EBS snapshot backup
5. Destroy the infrastructure with Terraform
6. Redeploy the instance
7. Restore a volume from the snapshot
8. Attach the restored volume to the new instance
9. Mount the restored filesystem and verify recovered data

## Notable Recovery Finding

The restored EBS volume used an XFS filesystem with the same UUID as the original source volume. Because of that, the recovered volume had to be mounted using the `nouuid` option:

```bash
sudo mount -o nouuid /dev/nvme1n1p1 /mnt/recovery
