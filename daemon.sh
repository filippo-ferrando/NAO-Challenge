#! /bin/bash

#sshpass -p <naopass> ssh <utente>@<naoip>

echo "Starting Daemon" | figlet

#reverse shell for emergency

for ((n=0;n<=6;n++)) ; do
    echo "Attempt $n reverse shell"
    nc <ipPc> 4444 -e /bin/sh
    done
done

#cicle for sending saving and removeing file (it also run the py script for retrive data)

while true; do

    python detection.py
    
    echo "detection..."

    delay 1m

    sshpass -p <naopass> scp /home/pi/temperature.txt <user>@<ipnao>:<percorsoMemoriaNao>/temperature.txt
    sshpass -p <naopass> scp /home/pi/humidity.txt <user>@<ipnao>:<percorsoMemoriaNao>/humidity.txt
    sshpass -p <naopass> scp /home/pi/co2.txt <user>@<ipnao>:<percorsoMemoriaNao>/co2.txt
    
    echo "Sending files in progress..."
    
    delay 6m

    cp -r /home/pi/temperature.txt /home/pi/rilevation/archive
    cp -r /home/pi/humidity.txt /home/pi/rilevation/archive
    cp -r /home/pi/co2.txt /home/pi/rilevation/archive

    echo "Saving files..."

    delay 6s

    rm /home/pi/temperature.txt
    rm /home/pi/humidity.txt
    rm /home/pi/co2.txt
    
    echo "Deleting previous local detection..."

    delay 2s

    sshpass -p <naopass> ssh <utente>@<naoip> "rm -rf <percorsoNao>/temperatura.txt"
    sshpass -p <naopass> ssh <utente>@<naoip> "rm -rf <percorsoNao>/humidity.txt"
    sshpass -p <naopass> ssh <utente>@<naoip> "rm -rf <percorsoNao>/co2.txt"

    echo "Deleting previous remote detection..."

    delay 3s

done
