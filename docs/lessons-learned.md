# Lessons Learned

This document summarizes key insights and architectural improvements identified during the EC2 disaster recovery lab.

The goal of this reflection is to identify design improvements and operational considerations for production environments.

---

# 1. Separate Application Data from the Root Disk

In this lab, application data was stored on the EC2 root volume.

While functional for testing, this approach is not ideal for production environments.

A better design is to place application data on a dedicated EBS data volume.

Example architecture:
EC2 Instance
├── Root Volume (Operating System)
└── Data Volume (/app-data)
Benefits of this approach:

- Faster recovery
- Easier volume replacement
- Reduced risk of data loss
- Independent backup policies for application data

---

# 2. Snapshot Recovery Can Introduce Filesystem UUID Conflicts

During the recovery process, the restored EBS volume used an XFS filesystem with the same UUID as the original root volume.

Linux prevents mounting two filesystems with identical UUID values.

This required mounting the recovered filesystem using the `nouuid` option:
sudo mount -o nouuid /dev/nvme1n1p1 /mnt/recovery
This behavior is expected when mounting cloned XFS filesystems and should be considered when designing recovery procedures.

---

# 3. Infrastructure-as-Code Simplifies Disaster Recovery

Using Terraform significantly simplified the recovery process.

Instead of manually recreating infrastructure, the environment could be rebuilt with a single command:
terraform apply
Benefits include:

- consistent infrastructure rebuilds
- version-controlled infrastructure configuration
- faster recovery time
- reduced configuration drift

---

# 4. Secure-by-Design Access Improves Security

The environment used AWS Systems Manager Session Manager instead of SSH.

Advantages:

- no inbound SSH ports required
- no SSH key management
- IAM-based access control
- centralized session logging

This approach significantly reduces attack surface compared to traditional SSH-based administration.

---

# 5. Automated Snapshot Policies Improve Reliability

Manual snapshots are useful for testing but are not reliable for production backup strategies.

Implementing AWS Data Lifecycle Manager allows snapshots to be automatically created on a schedule.

The lifecycle policy implemented in this lab:

- targets volumes tagged with `Backup=true`
- creates snapshots automatically
- retains a fixed number of recovery points

This ensures backups are consistently maintained without manual intervention.

---

# 6. Documentation Is Critical for Recovery Operations

The creation of an incident report, recovery runbook, and troubleshooting log significantly improves operational readiness.

In real environments, clear documentation ensures that recovery procedures can be executed quickly and consistently by any engineer on the team.

---

# Future Improvements

Potential enhancements for this environment include:

- moving application data to a dedicated EBS data volume
- implementing cross-region snapshot replication
- adding CloudWatch monitoring and alerting
- automating recovery workflows with Lambda and EventBridge
- modularizing Terraform configurations
