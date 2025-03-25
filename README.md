# EC2 EBS Snapshot Backup Automation

This project automates the backup and cleanup of EBS volumes attached to EC2 instances using a shell script and AWS CLI. It supports logging, scheduled execution with `cron`, and email alerts via Amazon SES.

---

## 🔧 Features

- Automatically creates snapshots for all EBS volumes attached to running EC2 instances.
- Deletes snapshots older than a specified retention period.
- Logs all operations to a daily log file.
- Sends email notifications after every run using AWS SES.
- Fully configurable through a separate `config.sh` file.
- Can be scheduled to run daily via `cron`.

---

## 🧰 Requirements

- AWS CLI installed and configured using `aws configure` or an EC2 IAM Role
- Verified email address in Amazon SES (for sending email alerts)
- Ubuntu/Linux server (tested on EC2 instance)
- `cron` enabled and running

---

## ⚙️ Setup Instructions

1. Clone the project or upload it to your EC2 instance.
2. Navigate into the project directory.
3. Make the script executable:

   ```bash
   chmod +x backup.sh
   ```

4. Edit `config.sh` and set:
   - Your AWS region
   - Snapshot retention period (in days)
   - Verified sender email address (from SES)

---

## 🚀 Manual Execution

Run the script manually:

```bash
./backup.sh
```

After running, you'll find log files in the `logs/` folder. You can view the latest log using:

```bash
cat logs/backup_YYYY-MM-DD.log
```

---

### ✅ Sample Output from Terminal

![Terminal Output](https://github.com/user-attachments/assets/d35c8f74-8d58-4c14-a4a2-8f455125332d)

---

### ✅ Snapshot Created in EC2 Console with Tag

After the script runs, you’ll see a new snapshot in the EC2 console tagged like this:

![EBS Snapshot Tag](https://github.com/user-attachments/assets/4d435c07-b161-4360-a506-ea1850ca5fd5)

---

### ✅ Email Notification from Amazon SES

You will also receive an email containing the log summary after each run:

![Email Alert](https://github.com/user-attachments/assets/b2cd4538-acd8-4bcb-9c3d-d8cc64924b12)

---

## ⏰ Automating with Cron

The script can be scheduled using a cron job to run every day at 2:00 AM UTC.

For testing purposes, I modified the time temporarily to ensure cron was working.

### Example Steps:

1. Edit `cronjob.txt` to include your desired time and script path.

2. Load the cron job:

   ```bash
   crontab cronjob.txt
   ```

3. Verify the cron job was added:

   ```bash
   crontab -l
   ```

---

## 📜 License

This project is licensed under the MIT License.
