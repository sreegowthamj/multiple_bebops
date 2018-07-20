#!/bin/sh
#Set the SSID, Password and IP
SSID='AndroidAP-sgj'	# Change this to your SSID
PW='yaot2326' 		# Change this to the password of your wifi network
IP=192.168.73.1 	# Change this to the desired Bebop IP	

#/data/ftp/internal_000/bin/wpa_passphrase $SSID $PW > /etc/wpa_supplicant.conf && 
#Connect to defined Network
BLDC_Test_Bench -M 2 >/dev/null
sleep 1 &&
/bin/mount -o remount,rw / &&
sleep 1 &&
/bin/sync &&
sleep 1 &&
/bin/sync &&
ifconfig   && # eth0 $IP && 
sleep 1 &&
/bin/mount -o remount,rw / &&
sleep 1 &&
sleep 1 &&
/bin/sync &&
sleep 1 &&
echo "Releasing lease.." | tee -a /data/ftp/internal_000/bin/log.txt &&
#udhcpc -v -R -i eth0 | tee -a /data/ftp/internal_000/bin/log.txt &&
ifconfig eth0 down &&
ifconfig eth0 up &&
echo "Releasing lease done" | tee -a /data/ftp/internal_000/bin/log.txt &&
sleep 1 &&
/bin/sync &&
echo "wpa_supplicant request initiated" | tee -a /data/ftp/internal_000/bin/log.txt &&
/data/ftp/internal_000/bin/wpa_supplicant -B -dd  -D wext -i eth0 -c /etc/wpa_supplicant.conf | tee /data/ftp/internal_000/bin/log.txt && 
echo "completed wpa_supplicant" | tee -a /data/ftp/internal_000/bin/log.txt &&
sleep 3 &&
/bin/sync &&
BLDC_Test_Bench -M 2 || true &&
sleep 3 &&
/bin/sync &&
BLDC_Test_Bench -M 2 || true &&
sleep 1 &&
sleep 1 &&
ifconfig eth0 192.168.43.109 &&
iwconfig eth0 essid 'AndroidAP-sgj' &&
/bin/sync &&
sleep 2 &&
echo "starting udhcpc" | tee -a /data/ftp/internal_000/bin/log.txt &&
/bin/sync &&
/sbin/udhcpc -v  -i eth0 -r 192.168.43.109 -H BebopWhite  | tee -a /data/ftp/internal_000/bin/log.txt &&
/bin/sync &&
echo "completed udhcpc" | tee -a /data/ftp/internal_000/bin/log.txt &&
/bin/sync &&
/data/ftp/internal_000/bin/iwconfig | tee -a /data/ftp/internal_000/bin/log.txt &&
/bin/sync &&
ifconfig -a | tee -a /data/ftp/internal_000/bin/log.txt &&
/bin/sync &&
route -n | tee -a /data/ftp/internal_000/bin/log.txt &&
/bin/sync &&
BLDC_Test_Bench -M 2 >/dev/null  || true &&
sleep 3 &&
echo "Adding default gateway" | tee -a /data/ftp/internal_000/bin/log.txt &&
route add default gw 192.168.43.1 | tee -a /data/ftp/internal_000/bin/log.txt || true &&
echo "Adding default gateway completed" | tee -a /data/ftp/internal_000/bin/log.txt &&
BLDC_Test_Bench -M 2 >/dev/null &&
sleep 3 &&
/bin/sync &&
netstat -rn | tee -a /data/ftp/internal_000/bin/log.txt &&
echo "Adding netstat op completed" | tee -a /data/ftp/internal_000/bin/log.txt &&
/bin/sync &&
sleep 3 &&
echo "trying ping gateway..." | tee -a /data/ftp/internal_000/bin/log.txt &&
ping 192.168.43.1 | tee -a /data/ftp/internal_000/bin/log.txt &&
echo "done ping gateway." | tee -a /data/ftp/internal_000/bin/log.txt &&
/bin/sync &&
sleep 3
