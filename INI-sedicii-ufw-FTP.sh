#!/bin/bash

#variables
ftpuser=
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
sudo echo "listen=NO
listen_ipv6=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
pasv_enable=YES
pasv_min_port=40000
pasv_max_port=50000

#Setting up SSL
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=YES
rsa_cert_file=/etc/ssl/private/vsftpd.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.pem
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
require_ssl_reuse=NO
ssl_ciphers=HIGH

#Useful when managing web apps where “.files” are common
force_dot_files=YES" > /etc/vsftpd.conf

#Restart ftp
sudo systemctl restart vsftpd

#Return to original pwd
cd $pwd










