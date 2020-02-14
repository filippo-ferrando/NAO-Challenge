#! /bin/bash

chmod +x daemon.sh

echo "Installing DHT 22 libraries..." 

sleep 1s

echo "Cloning Repo..."

git clone https://github.com/adafruit/Adafruit_Python_DHT.git

echo "Installing..."

cd Adafruit_Python_DHT/

sudo apt-get update
sudo apt-get install build-essential python-dev python-openssl
sudo python setup.py install

sleep 1s

clear

echo "Installing mhz19 libraries..."

sleep 1s

pip install mh-z19

sleep 1s

clear

#echo "Adding autostart daemon"

#echo "./daemon.sh" >> ~/.bashrc

sleep 1s

clear

echo "Installation complete ! " | figlet

sleep 3s

clear
