# AWS Resource Watch 🚨

A simple GitHub Actions‑based monitoring tool for AWS resources.  
Runs daily, checks S3 buckets, EC2 instances, Lambda functions, and IAM users.  
Sends email alert if something is unexpected.

---

## ✅ Features

- Scheduled runs using GitHub Actions (cron)  
- AWS CLI script to fetch resource state  
- Threshold-based check (e.g. alert if **no** EC2 instances)  
- Email alert on failure using SMTP  
- Logs/artifacts for every run  

---

## 📁 Project Structure

aws-resource-watch/
├── scripts/
│ └── aws_monitor.sh # Main monitoring script
├── .github/
│ └── workflows/
│ └── monitor.yml # Workflow configuration
├── sample_output.log # Example of output log
├── README.md
└── LICENSE


---

## 🛠 Prerequisites

- AWS account, with IAM user having **read‑only** access as defined above  
- AWS CLI installed locally (for testing manually)  
- GitHub repository (public or private)  
- SMTP server credentials (e.g. Gmail app password)  

---

## 🚀 Setup Guide

1. Fork / clone this repository.  
2. Create IAM user in AWS with minimal read‑only policy. Collect the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.  
3. In GitHub repo settings → **Secrets**, add:

   - `AWS_ACCESS_KEY_ID`  
   - `AWS_SECRET_ACCESS_KEY`  
   - `SMTP_USERNAME`  
   - `SMTP_PASSWORD`

4. Adjust region in `monitor.yml` and thresholds in `aws_monitor.sh` if needed (for example, set different conditions to consider “failure”).

5. Trigger workflow manually to test: in **Actions** tab, select “AWS Resource Monitor” → **Run workflow** (workflow_dispatch).

6. Check logs/artifacts after run, verify that email alert is triggered on failure scenarios.  

---

## 🔒 IAM & Security

- The IAM user has only minimal permissions required to list or describe AWS resources. No destructive permissions.  
- GitHub repository secrets are used to store credentials, not hardcoded.  
- Email credentials are stored securely via GitHub Secrets.

---

## 🎯 What This Project Achieves

- Demonstrates automation using real cloud APIs (AWS)  
- Shows use of **GitHub Actions** in in CI/CD pipelines  
- Shows how handle alerts/monitoring

---

## 🛡 Possible Extensions (for future)

- Add alerts for unexpected usage or cost anomalies (EBS volumes, unused snapshots)  
- Use richer monitoring (push metrics to CloudWatch, Grafana)  
- Slack / Teams alert instead of email  
- Maintain historical data in a datastore (e.g., commit the log, or store in DynamoDB/S3) for trend analysis  

---

## 📜 License

MIT License – feel free to reuse/modify.

