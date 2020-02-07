#! /bin/bash

#sshpass -p <naopass> ssh <utente>@<naoip>

while(1){

    python detection.py

    delay 1m

    scp /home/pi/data/temperature.txt <user>@<ipnao>:<percorsoMemoriaNao>/temperature.txt
    scp /home/pi/data/humidity.txt <user>@<ipnao>:<percorsoMemoriaNao>/humidity.txt
    scp /home/pi/data/co2.txt <user>@<ipnao>:<percorsoMemoriaNao>/co2.txt

    delay 6m
    rm /home/pi/data/temperature.txt
    rm /home/pi/data/humidity.txt
    rm /home/pi/data/co2.txt
    
    delay 2s

    sshpass -p <naopass> ssh <utente>@<naoip> "rm -rf <percorsoNao>/temperatura.txt"
    sshpass -p <naopass> ssh <utente>@<naoip> "rm -rf <percorsoNao>/humidity.txt"
    sshpass -p <naopass> ssh <utente>@<naoip> "rm -rf <percorsoNao>/co2.txt"

}
