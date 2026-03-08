# Implementation Summary

## Project Goal

The goal of this project was to simulate a disaster recovery scenario in AWS and demonstrate the ability to restore application data using EBS snapshots and infrastructure rebuilt with Terraform.

The environment was designed to follow secure-by-design principles and minimize direct network access to the instance.

---

# Infrastructure Deployment

Infrastructure was deployed using Terraform. The Terraform configuration provisions the following resources:

- EC2 instance running Amazon Linux 2023
- Encrypted gp3 EBS root volume
- IAM role and instance profile for Systems Manager
- Security configuration enabling Session Manager access
- Data Lifecycle Manager policy for automated snapshots

Terraform was used for both initial deployment and recovery deployment.

---

# Secure Access Configuration

Instead of SSH access, the instance is accessed through **AWS Systems Manager Session Manager**.

Benefits:

- No inbound SSH ports
- No key pair management
- IAM-based access control
- Fully auditable session logs

The instance profile includes the `AmazonSSMManagedInstanceCore` policy to allow SSM connectivity.

---

# Application Data Creation

Application data was simulated by creating a directory structure on the instance:
