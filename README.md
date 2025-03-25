# EC2 EBS Snapshot Backup Script

This shell script automates the creation and cleanup of EBS volume snapshots attached to EC2 instances using AWS CLI.

## 🔧 Features
- Auto-create snapshots for all EC2 volumes
- Auto-delete snapshots older than specified days
- Logs all operations
- Easily configurable via `config.sh`

## 🧰 Requirements
- AWS CLI configured with appropriate IAM permissions
- Shell environment (Linux/macOS)
- cron (for scheduling)

## 🚀 Usage
```bash
chmod +x backup.sh
./backup.sh
```

## 📅 Scheduling with Cron
Add the following line to your crontab to run daily at 2 AM:
```
0 2 * * * /path/to/backup.sh
```

## 📜 License
MIT License
