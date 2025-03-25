#!/bin/bash
source ./config.sh

mkdir -p ./logs

echo "Starting EC2 EBS Snapshot Backup - $(date)" >> "$LOG_FILE"

# Get all instance IDs
INSTANCE_IDS=$(aws ec2 describe-instances   --query 'Reservations[*].Instances[*].InstanceId'   --output text --region "$AWS_REGION")

for INSTANCE_ID in $INSTANCE_IDS; do
  echo "Processing instance: $INSTANCE_ID" >> "$LOG_FILE"

  # Get all attached volume IDs
  VOLUME_IDS=$(aws ec2 describe-instances     --instance-ids "$INSTANCE_ID"     --query 'Reservations[*].Instances[*].BlockDeviceMappings[*].Ebs.VolumeId'     --output text --region "$AWS_REGION")

  for VOLUME_ID in $VOLUME_IDS; do
    echo "Creating snapshot for volume: $VOLUME_ID" >> "$LOG_FILE"

    SNAPSHOT_ID=$(aws ec2 create-snapshot       --volume-id "$VOLUME_ID"       --description "Backup of $VOLUME_ID from $INSTANCE_ID"       --tag-specifications "ResourceType=snapshot,Tags=[{Key=Backup,Value=$SNAPSHOT_TAG}]"       --query 'SnapshotId'       --output text --region "$AWS_REGION")

    echo "Created snapshot $SNAPSHOT_ID" >> "$LOG_FILE"
  done
done

# Delete old snapshots
echo "Cleaning up snapshots older than $RETENTION_DAYS days..." >> "$LOG_FILE"
SNAPSHOT_IDS=$(aws ec2 describe-snapshots   --filters "Name=tag:Backup,Values=$SNAPSHOT_TAG"   --owner-ids self   --query "Snapshots[?StartTime<='$(date -d "$RETENTION_DAYS days ago" --iso-8601=seconds)'].SnapshotId"   --output text --region "$AWS_REGION")

for SNAP_ID in $SNAPSHOT_IDS; do
  echo "Deleting old snapshot: $SNAP_ID" >> "$LOG_FILE"
  aws ec2 delete-snapshot --snapshot-id "$SNAP_ID" --region "$AWS_REGION"
done

echo "Backup and cleanup completed at $(date)" >> "$LOG_FILE"



# Email SES Alert
EMAIL_TO="pavanvinjamuri017@gmail.com"
EMAIL_FROM="pavanvinjamuri017@gmail.com"  # Must be a verified sender in SES
EMAIL_SUBJECT="✅ EC2 EBS Backup Completed on $(hostname)"
EMAIL_BODY=$(cat "$LOG_FILE")

aws ses send-email \
    --region "$AWS_REGION" \
    --from "$EMAIL_FROM" \
    --destination "ToAddresses=$EMAIL_TO" \
    --message "Subject={Data='$EMAIL_SUBJECT'},Body={Text={Data='$EMAIL_BODY'}}" \
    | jq -r '.MessageId'

