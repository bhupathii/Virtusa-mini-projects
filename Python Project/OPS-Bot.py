# OpsBot - Automatic Security Log Analyzer
# Steps:
#   1. Reads server.log line by line
#   2. Finds lines with CRITICAL, ERROR, or FAILED LOGIN
#   3. Counts how many of each were found
#   4. Saves results to security_alert_[today's date].txt
#   5. Prints the file size to confirm it worked
import os
from datetime import date

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
log_file   = os.path.join(SCRIPT_DIR, "server.log")
today      = date.today().strftime("%Y-%m-%d")
alert_file = os.path.join(SCRIPT_DIR, f"security_alert_{today}.txt")

danger_keywords = ["CRITICAL", "ERROR", "FAILED LOGIN"]

print("OpsBot starting...")
print(f"Reading: {log_file}\n")
alert_lines = []
error_counts = {}
with open(log_file, "r") as f:
    for line in f:
        for keyword in danger_keywords:
            if keyword in line:
                alert_lines.append(line)
                if keyword not in error_counts:
                    error_counts[keyword] = 0
                error_counts[keyword] += 1
                break

print("--- Scan Complete ---")
print(f"Total suspicious lines found:{len(alert_lines)}\n")
print("Breakdown by type:")
for keyword,count in error_counts.items():
    print(f"{keyword}:{count}")

print(f"\nWriting report to:{alert_file}")
with open(alert_file,"w")as f:
    f.write("="*60+"\n")
    f.write(f"  SECURITY ALERT REPORT - {today}\n")
    f.write("="*60+"\n\n")
    f.write("SUMMARY\n")
    f.write("-"*30+"\n")
    for keyword,count in error_counts.items():
        f.write(f"{keyword}:{count}\n")
    f.write(f"\n  TOTAL suspicious lines: {len(alert_lines)}\n")
    f.write("\n\n")
    f.write("FULL SUSPICIOUS LOG LINES\n")
    f.write("-"*30+"\n")
    for line in alert_lines:
        f.write(line)

file_size = os.path.getsize(alert_file)
print(f"Report file size: {file_size} bytes")
print("\nOpsBot done. Check the alert file for details.")