Create a Bash script that performs basic system monitoring, log management, and notification of low disk space. The script should cover file handling, conditionals, loops, process monitoring, and working with external commands.


Requirements:


 1.Check System Information:

Display the current system's uptime.
Display total and available memory using the free command.


 2.Monitor Disk Usage:

Check the disk usage on the system (e.g., using df).
If any partition exceeds a given threshold (e.g., 80% usage), write a message to a log file and notify the user via output.df
Display human-readable disk space information.


 3.Backup Critical Log Files:

Create a directory if it doesn’t exist (e.g., /backup_logs).
Copy /var/log/syslog or /var/log/messages to this directory with a timestamp.
Compress the copied logs using tar or gzip.


 4.User and Process Monitoring:

List the currently logged-in users.
Display the top 5 processes by memory usage.
If a certain process (e.g., nginx) is not running, write to the log file and output a message.


 5.Network Check:

Ping a given server (e.g., google.com) and log whether the connection was successful or failed.


 6.Cron Job Setup:

Provide a line at the end of the script that shows how the script can be set up as a cron job (scheduled task) to run daily.


 7.Notifications:

If any of the monitoring checks (disk usage, process check, or network check) fails, append a warning message to the log file.


 8.Comments and Best Practices:

Use comments to explain the purpose of each section.
Follow best practices for error handling, such as checking if commands succeeded and handling missing files or permissions gracefully.
