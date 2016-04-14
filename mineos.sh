#!/bin/sh

#Make sure to make this a script file and not just copy paste all lines in ssh only#

apt-get update
apt-get -y upgrade
apt-get -y install htop iotop vim git curl

###########################Install Mineos###################################################

# update repositories
curl -sL https://deb.nodesource.com/setup_5.x | bash -
apt-get update

# download the necessary prerequisite components for mineos
apt-get -y install nodejs git rdiff-backup screen build-essential openjdk-8-jre-headless

# download the most recent mineos web-ui files from github
mkdir -p /usr/games
cd /usr/games
git clone https://github.com/hexparrot/mineos-node.git minecraft
cd minecraft
git config core.filemode false
chmod +x service.js mineos_console.js generate-sslcert.sh webui.js
ln -s /usr/games/minecraft/mineos_console.js /usr/local/bin/mineos
cp mineos.conf /etc/mineos.conf
npm install

# distribute service related files
cp /usr/games/minecraft/init/systemd_conf /etc/systemd/system/mineos.service
systemctl enable mineos
systemctl start mineos

# generate self-signed certificate
./generate-sslcert.sh

# start the background service
#start mineos
systemctl enable mineos
systemctl start mineos
###########################Done with Mineos###################################################




