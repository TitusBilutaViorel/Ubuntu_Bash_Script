#!/bin/bash
#System Monitoring, Log Management, Notification on low disk space

echo "......."
echo "......."

echo "1. Check System Information"

echo "..."

echo "Current system's uptime:"
uptime -p
uptime -s

echo "......."

echo "Total and available RAM:"
free

echo "......."
echo "......."

echo "2. Monitor Disk Usage"

echo "..."

df

echo "......."

#If any partition exceeds a given threshold, write a message to a log file and notify the user via output.

echo "Partition exceeds 80% usage:"

df | awk 'NR>1 {sub("%","",$5); if ($5 + 0 > 80) print $1, $5"%";}' > logfiles/logfile.log

# NR>1 -> elimina linia 1 cu scris: Usage,
# sub(%,,$5) -> elimina caracterul %
# $5 -> alege doar coloana 5 (Usage)
# +0 -> forteaza conversia unei valori dintr-un string in numar, altfel compara 1 cu 8, nu 100 cu 80
# print $1, $5 % -> tipareste numele sistemului de fisiere si procentul

echo "......."

df -H

echo "......."
echo "......."

echo "3. Backup Critical Log Files"

echo "..."

echo "Copy syslog to backup_logs directory:"

cp /var/log/syslog backup_logs/syslog_$(date +"%d%m%Y_%H%M%S").log

echo "......."

echo "Compress the copied logs:"

tar -czvf backup_logs.tar.gz backup_logs

# c -> creeaza o arhiva noua
# z -> comprima arhiva folosind gzip
# v -> afiseaza procesul de arhivare
# f -> specifica numele fisierului arhiva

echo "......."
echo "......."

echo "4. User and Process Monitoring"

echo "..."

echo "The currently logged-in users:"

who -u

echo "......."

echo "Top 5 processes by memory usage:"

ps aux --sort -rss | head -n 6

# ps aux -> afiseaza procesele
# rss -> sorteaza in ordine descrescatoare
# head -n 6 -> selecteaza primele 6 linii

echo "......."
