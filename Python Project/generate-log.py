import os
import random
from datetime import datetime, timedelta, timezone

# --- Settings ---
TOTAL_LINES = 5000
SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
OUTPUT_FILE = os.path.join(SCRIPT_DIR, "server.log")

# --- Sample data to make logs feel real ---
users = ["Manoj", "Sara", "Chanakya", "root", "admin", "unknown", "Karthik"]
ips   = ["192.168.1.10", "10.0.0.5", "203.0.113.42", "198.51.100.7", "172.16.0.3"]
services = ["sshd", "nginx", "mysql", "kernel", "systemd", "cron"]

info_messages = [
    "Service started successfully",
    "Backup completed",
    "Health check passed",
    "Connection accepted",
    "Cache refreshed",
    "Scheduled job ran",
]

error_messages = [
    "Disk I/O error on /dev/sda",
    "Database connection timeout",
    "Memory allocation failed",
    "Socket bind error on port 443",
]

critical_messages = [
    "CPU temperature exceeded threshold",
    "RAID array degraded",
    "Out of memory — killing process",
    "Filesystem read-only due to errors",
]

# --- Build the log file ---
# Calculate start time so the last log entry lands at today's date/time
total_duration = timedelta(seconds=(TOTAL_LINES - 1) * 17)
start_time = datetime.now() - total_duration

with open(OUTPUT_FILE, "w") as log:
    for i in range(TOTAL_LINES):

        # Move time forward a bit each line
        timestamp = start_time + timedelta(seconds=i * 17)
        ts = timestamp.strftime("%Y-%m-%d %H:%M:%S")

        service = random.choice(services)
        ip      = random.choice(ips)
        user    = random.choice(users)

        # Decide what kind of log line this is
        # 85% INFO, 8% ERROR, 4% CRITICAL, 3% FAILED LOGIN
        roll = random.random()

        if roll < 0.85:
            msg   = random.choice(info_messages)
            level = "INFO"
            line  = f"[{ts}] [{level}] [{service}] {msg}"

        elif roll < 0.93:
            msg   = random.choice(error_messages)
            level = "ERROR"
            line  = f"[{ts}] [{level}] [{service}] {msg}"

        elif roll < 0.97:
            msg   = random.choice(critical_messages)
            level = "CRITICAL"
            line  = f"[{ts}] [{level}] [{service}] {msg}"

        else:
            # FAILED LOGIN line — looks realistic
            level = "WARNING"
            line  = f"[{ts}] [{level}] [sshd] FAILED LOGIN attempt for user '{user}' from {ip}"

        log.write(line + "\n")

print(f"Done! Created '{OUTPUT_FILE}' with {TOTAL_LINES} lines.")