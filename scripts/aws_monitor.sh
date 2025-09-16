#!/bin/bash
set -e

# This script will check AWS resources and report some basic info.
# Modify thresholds as needed.

# Logging
LOGFILE="aws_resource_report_$(date +'%Y%m%d_%H%M%S').log"
echo "AWS Resource Report - $(date)" > "$LOGFILE"

# Fetch data

echo -e "\n--- S3 Buckets ---" >> "$LOGFILE"
aws s3 ls >> "$LOGFILE" || echo "Error listing S3 buckets" >> "$LOGFILE"

echo -e "\n--- EC2 Instances ---" >> "$LOGFILE"
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PublicIpAddress]' --output table >> "$LOGFILE" || echo "Error describing EC2 instances" >> "$LOGFILE"

echo -e "\n--- Lambda Functions ---" >> "$LOGFILE"
aws lambda list-functions --query 'Functions[*].[FunctionName,Runtime,LastModified]' --output table >> "$LOGFILE" || echo "Error listing Lambda functions" >> "$LOGFILE"

echo -e "\n--- IAM Users ---" >> "$LOGFILE"
aws iam list-users --query 'Users[*].[UserName,CreateDate]' --output table >> "$LOGFILE" || echo "Error listing IAM users" >> "$LOGFILE"

# Example of a check: alert if there are no EC2 instances running
EC2_COUNT=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId]' --output text | wc -w)
if [ "$EC2_COUNT" -eq 0 ]; then
  echo "ALERT: No EC2 instances found!" >> "$LOGFILE"
  exit 1   # non-zero exit will cause the GitHub Action to recognize failure
fi

# Success
echo "Report completed successfully." >> "$LOGFILE"
exit 0

