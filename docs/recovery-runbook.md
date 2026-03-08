# Disaster Recovery Runbook

## Purpose

This runbook provides step-by-step instructions for restoring application data from an EBS snapshot after the loss of an EC2 instance.

The procedure assumes infrastructure is managed with Terraform and the environment uses AWS Systems Manager Session Manager for administration.

---

# Prerequisites

Before beginning recovery, verify the following:

- Terraform configuration is available
- A valid EBS snapshot exists
- AWS credentials are configured
- Access to AWS Systems Manager is available

---

# Step 1: Redeploy Infrastructure

Navigate to the Terraform directory.
