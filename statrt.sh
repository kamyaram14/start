#!/bin/bash
sudo apt update &> /dev/null && sudo apt upgrade &> /dev/null
sudo ufw allow 'ssh' 
sudo ufw enable
sudo ufw status
sudo apt install docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common &> /dev/null
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &> /dev/null
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" &> /dev/null
sudo apt update &> /dev/null
apt-cache policy docker-ce &> /dev/null
sudo apt install docker-ce &> /dev/null
sudo docker image build -t kamyarkalhor.ir .
sudo docker compose up -d
sudo chown -R $USER:$USER /var/www
git clone https://github.com/Voorivex/OOB-Server.git &> /dev/null
sudo chmod +x ./OOB-Server/setup
read -p "Enter Your Domain: " domain
read -p "Enter Your ServerIP: " ServerIP
sudo ./OOB-Server/setup domain ServerIP
sudo chown -R $USER:$USER /etc/bind
sudo echo "local            IN      A       127.0.0.1" >> /etc/bind/db.local
sudo echo "aws-ssrf         IN      A       169.254.169.254" >> /etc/bind/db.local
dig +short domain
read -p "Would you like to also install tools and GO? (y)es or (n)o " cont
if [[ "$cont" == "n" ]]; then
    echo "OK"
else
    chmod +x ./tools
    ./tools
fi