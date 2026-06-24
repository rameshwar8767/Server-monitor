#!/bin/bash

LOGFILE="health_report.log"

echo "SERVER HEALTH REPORT"
echo "Generated on: $(date)"


echo ""

echo "CPU Usage:"


top -bn1 | grep "Cpu"


echo ""
echo "Memory Usage:"


free -h


echo ""
echo "Disk Usage:"

df -h


echo ""
echo "Nginx Status:"


if systemctl is-active --quiet nginx
then
	echo "Nginx is Running"
else
	echo "Nginx is Stopped"

fi


echo ""



DISK=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$DISK" -gt 80 ]
then
	echo "WAENING: Disk usage above 80%"
fi


MEM=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2*100}')

if [ "$MEM" -gt 80 ]
then
	echo "Warning: High Memory Usage"
fi



