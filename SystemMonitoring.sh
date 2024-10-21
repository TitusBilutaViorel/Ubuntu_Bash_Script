#!/bin/bash
#System Monitoring, Log Management, Notification on low disk space

echo "......."
echo "......."

echo "1. Check System Information"

echo "..."

echo "Current system's uptime:"
uptime -p
uptime -s

# -p -> afiseaza acum cat timp sistemul a fost pornit  (pretty)
# -s -> afiseaza data si ora la care sistemul a fost pornit

echo "......."

echo "Total and available RAM:"
free

# free -> informatii despre memoria RAM

echo "......."
echo "......."

echo "2. Monitor Disk Usage"

echo "..."

df

# df -> informatii despre spatiul de stocare

echo "......."

echo "Partition exceeds 80% usage:"

df | awk 'NR>1 {sub("%","",$5); if ($5 + 0 > 80) print $1, $5"%";}' > logfiles/logfile.log

# NR>1 -> elimina linia 1 cu scris: Usage,
# sub(%,,$5) -> elimina caracterul %
# $5 -> alege doar coloana 5 (Usage)
# +0 -> forteaza conversia unei valori dintr-un string in numar, altfel compara 1 cu 8, nu 100 cu 80
# print $1, $5 % -> tipareste numele sistemului de fisiere si procentul

echo "......."

df -H

# df -H -> informatii despre spatiul de stocare in Mb, Kb, Gb, etc.

echo "......."
echo "......."

echo "3. Backup Critical Log Files"

echo "..."

echo "Copy syslog to backup_logs directory:"

cp /var/log/syslog backup_logs/syslog_$(date +"%d%m%Y_%H%M%S").log

# cp -> copiaza un fisier intr-un director dat 
# (date +"%d%m%Y_%H%M%S") -> adauga data si ora in denumirea fisierului

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

# who -u -> comanda pentru a afisa loggedin users

echo "......."

echo "Top 5 processes by memory usage:"

ps aux --sort -rss | head -n 6

# ps aux -> afiseaza procesele
# rss -> sorteaza in ordine descrescatoare
# head -n 6 -> selecteaza primele 6 linii

echo "......."

echo "Procces not running -> log file and message"

if pgrep -x "nginx"; then

	echo "nginx is running."
else
	echo "nginx is not running." >> logfiles/logfile.log

	echo "nginx is not running."
fi

# pgrep -x -> verifica daca procesul este deschis

echo "......."
echo "......."

echo "5. Network check"

echo "..."

if ping -c 1 "www.google.com"; then

	echo "Connection succesful." >> logfiles/logfile.log

else
	echo "Connection unsuccesful." >> logfiles/logfile.log
fi

# ping -c 1 -> trimite pachete catre serverul introdus

echo "......."
echo "......."

echo "6. Cron job setup"

echo "..."

echo "The created crontab file is locatet in root/var/spool/cron/crontabs."

echo "0 0 * * * /SystemMonitoring.sh"

# Primele 2 caractere (0, 0) sunt pentru minute si ore, iar urmatoarele pentru ziua lunii, luna si ziua saptamanii.

echo "......."
echo "......."
