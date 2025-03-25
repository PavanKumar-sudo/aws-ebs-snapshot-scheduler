#!/bin/bash

# AWS Region
AWS_REGION="us-east-1"

# Retention period (in days)
RETENTION_DAYS=7

# Log file
LOG_FILE="./logs/backup_$(date +%F).log"

# Tag for identifying snapshots created by script
SNAPSHOT_TAG="AutomatedBackup"
