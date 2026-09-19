#!/usr/bin/env bash

echo "---------- Server Status ----------"
echo "Date: $(date)"

echo
echo "---------- CPU Usage ----------"
top -bn1 | awk '/Cpu\(s\)/ {printf "Used: %.1f%%\n", 100 - $8}'

echo
echo "---------- Memory Usage ----------"
free | awk '/^Mem:/ {
    printf "Total: %.2f GiB | Used: %.2f GiB | Free: %.2f GiB | Used: %.1f%%\n",
    $2/1024/1024, $3/1024/1024, $4/1024/1024, $3/$2*100
}'

echo
echo "---------- Disk Usage ----------"
df -h / | awk 'NR==1 {print "Total Used Available Used%"} NR==2 {print $2, $3, $4, $5}'

echo
echo "---------- Top 5 Processes by CPU ----------"
ps aux --sort=-%cpu | head -n 6

echo
echo "---------- Top 5 Processes by Memory ----------"
ps aux --sort=-%mem | head -n 6
