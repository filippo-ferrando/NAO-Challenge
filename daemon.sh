#! /bin/bash

#sshpass -p <naopass> ssh <utente>@<naoip>

while(1){

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

}
