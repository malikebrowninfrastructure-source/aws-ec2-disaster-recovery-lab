# Incident Report: EC2 Data Recovery Simulation

## Incident Overview

This incident report documents a simulated infrastructure failure and recovery exercise performed in an AWS environment.

The purpose of the exercise was to validate the ability to restore application data from an EBS snapshot after infrastructure loss.

---

# Incident Summary

An EC2 instance hosting application data experienced a simulated infrastructure failure. The instance and associated resources were intentionally destroyed using Terraform to emulate a real-world outage scenario.

The recovery process involved redeploying the infrastructure, restoring an EBS volume from a snapshot backup, attaching the volume to a new instance, and verifying that the application data was successfully recovered.

---

# Environment

Cloud Platform: AWS  
Region: us-east-1  
Operating System: Amazon Linux 2023  
Infrastructure Management: Terraform  
Access Method: AWS Systems Manager Session Manager  

Key AWS Services:

- Amazon EC2
- Amazon EBS
- AWS Systems Manager
- AWS Data Lifecycle Manager

---

# Timeline of Events

### Initial Deployment

Terraform was used to deploy an EC2 instance with an encrypted gp3 EBS root volume.

The instance was configured with an IAM instance profile allowing access through AWS Systems Manager Session Manager.

---

### Application Data Creation

Application data was simulated by creating a directory structure and files on the instance:
