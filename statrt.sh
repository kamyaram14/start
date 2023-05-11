#!/bin/bash
sudo apt update && sudo apt upgrade
sudo ufw allow 'ssh'
sudo ufw enable
sudo ufw status
sudo apt install docker 
sudo apt install apt-transport-https ca-certificates curl software-properties-common 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
sudo chown -R $USER:$USER /var/www
sudo docker image build -t kamyarkalhor.ir .
cp ./php/index-ssrf.php /var/www/blindssrf/index.php
cp ./php/index-xss.php /var/www/blindxss/index.php
cp ./php/r.php /var/www/main/r.php
echo "Hello world" > /var/www/main/index.html
sudo docker compose up -d

read -p "Would you like to also install OOB-Server? (y)es or (n)o " cont_1
if [[ "$cont_1" == "n" ]]; then
    echo "OK"
else
    chmod +x ./install_OOB
    ./install_OOB
fi

read -p "Would you like to also install tools and GO? (y)es or (n)o " cont_2
if [[ "$cont_2" == "n" ]]; then
    echo "OK"
else
    chmod +x ./tools
    ./tools
fi