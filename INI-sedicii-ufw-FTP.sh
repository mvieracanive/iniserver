#!/bin/bash

#variables
ftpuser=PONERUSUARIOFTP
ftpuserhome=/home/$ftpuser
ssldays=365
sslkeyfilepath=/etc/ssl/private/vsftpdkey.pem
sslcertfilepath=/etc/ssl/private/vsftpdcert.pem
nodeserverfolder=NodeServer
websiteport=80
pwd=$(pwd)
chiselServerAppName=ChiselServer


#Setting up initial configuration of firewall
sudo ufw allow ssh
sudo ufw allow OpenSSH
sudo ufw enable
echo FIREWALL SET UP WITH SSH ENABLED FOR DEFAULT PORT

#Installing FTP software
sudo apt update && sudo apt install vsftpd

#Add FTP rules at firewall and create ftp user
sudo ufw allow 20/tcp
sudo ufw allow 21/tcp
sudo ufw allow 40000:50000/tcp
sudo ufw allow 990/tcp
echo NOW USER $ftpuser WILL BE CREATED FOR ACCESSING FTP, PLREASE PAY ATTENTION TO PASSWORD AND INFORMATION ENTERED FOR NEW USER
sudo adduser --home $ftpuserhome $ftpuser

#Generate SSL certificate
echo NOW A PRIVATE KEY AND CERTIFICATE WILL BE GENERATED FOR ENEBLING SFTP, PAY ATTENTION TO THE INFORMATION INPUT
sudo openssl req -x509 -nodes -days $ssldays -newkey rsa:2048 -keyout $sslkeyfilepath -out $sslcertfilepath

#Create folder and permissions of $ftpuser
sudo chown -R $ftpuser $ftpuserhome
sudo chmod -R 700 $ftpuserhome
#Backup ftp conf file in vsftpd.conf.bak
echo NOW vsftpd.conf FILE WILL BE CONFIGURED, BUT A BACKUP WILL BE SAVED IN FILE /etc/vsftpd.conf.bak 
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
sudo rm /etc/vsftpd.conf
sudo cp vsftpd.conf /etc/vsftpd.conf

#Restart ftp
sudo systemctl restart vsftpd

#Return to original pwd
cd $pwd










