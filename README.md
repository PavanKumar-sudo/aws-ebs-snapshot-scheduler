EC2 EBS Snapshot Backup Automation
This project automates the backup and cleanup of EBS volumes attached to EC2 instances using a shell script and AWS CLI. It supports logging, scheduled execution with cron, and email alerts via Amazon SES.

Features
Automatically creates snapshots for all EBS volumes attached to running EC2 instances.

Deletes snapshots older than a specified retention period.

Logs all operations to a daily log file.

Sends email notifications after every run using AWS SES.

Fully configurable through a separate config.sh file.

Can be scheduled to run daily via cron.

Requirements
AWS CLI installed and configured using the aws configure

Verified email address in AWS SES (for email alerts)

Ubuntu/Linux server (tested on EC2 instance)

cron enabled and running


Setup Instructions
Clone the project or upload it to your EC2 instance.

Navigate into the project directory.

Make the script executable:

bash
Copy
Edit
chmod +x backup.sh
Edit config.sh and set:

Your AWS region

Snapshot retention period (in days)

Verified email address (from SES)

Manual Execution
To manually run the backup:

bash
Copy
Edit
./backup.sh
To check the log:
once you did this one you will get the log file under the logs folder if you want you can see the log file by using cat command and after that go to aws console check the shapshot in ec2 it will created the new shapshot with time and date.
![image](https://github.com/user-attachments/assets/d35c8f74-8d58-4c14-a4a2-8f455125332d)
After check the tag it look like this
![image](https://github.com/user-attachments/assets/4d435c07-b161-4360-a506-ea1850ca5fd5)

After that you will receive the email to your emaillike below.

![image](https://github.com/user-attachments/assets/b2cd4538-acd8-4bcb-9c3d-d8cc64924b12)

cat logs/backup_YYYY-MM-DD.log
Automating with Cronjob: i schedule the backup everyday 2:00 AM but for checking the crontab is working i used the below method.

Edit cronjob.txt to match your server path and desired time.

Load the cron job:

bash
Copy
Edit
crontab cronjob.txt
To verify:

bash
Copy
Edit
crontab -l
License
This project is licensed under the MIT License.
