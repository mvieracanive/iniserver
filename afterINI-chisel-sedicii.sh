#!/bin/bash

#Install Chisel
sudo curl https://i.jpillora.com/chisel! | bash

#Demonize web server script
sudo npm install pm2@latest -g

#Demonize portfolio
sudo chmod u+x script_chiselserver.sh
sudo pm2 start script_chiselserver.sh --name ChiselServer --watch --log chisel.log --time
echo NOW PM2 WILL BE CONFIGURED TO START WITH EVERY REBOOT, PLEASE FOLLOW CAREFULLY INDICATIONS
sudo pm2 startup


