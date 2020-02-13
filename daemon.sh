#! /bin/bash

#sshpass -p <naopass> ssh <utente>@<naoip>

echo "Starting Daemon" | figlet #only a cool start

#reverse shell for emergency connection, if it will not find any connection, it will move on

echo "Attempt reverse shell"

rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1 | nc <ipPc> 4444 -q 10 > /tmp/f  #work-around for netcat -e option
sleep 10s

#cicle for sending saving and removing file (it also run the py script for retrive data)

while true; do
    #creating variable for folder(yyyy-mm-dd)
    d=$(date -I)
    #creating variable for files (hh-mm)
    o=$(date +%R)

    python detection.py #retrive data from sensor
    
    echo "Detection..."

    sleep 10s  #security of data presence delay

    sshpass -p <naopass> scp /home/pi/temperature.txt <user>@<ipnao>:<percorsoMemoriaNao>/temperature.txt       #sending over ssh protocol temp, humdity and co2 files
    sshpass -p <naopass> scp /home/pi/humidity.txt <user>@<ipnao>:<percorsoMemoriaNao>/humidity.txt
    sshpass -p <naopass> scp /home/pi/co2.txt <user>@<ipnao>:<percorsoMemoriaNao>/co2.txt
    
    echo "Sending files in progress..."

    sleep 3s

    #check if folder exist, if not it will make it

    mkdir /home/pi/rilevation/$d

    #rename files with adding h,m
    mv /home/pi/temperature.txt /home/pi/temperature-$o.txt
    mv /home/pi/humidity.txt /home/pi/humidity-$o.txt
    mv /home/pi/co2.txt /home/pi/co2-$o.txt

    #copy file in rilevation/$d directory
    cp /home/pi/temperature-$o.txt ~/rilevation/$d    #saving file in archive directory
    cp /home/pi/humidity-$o.txt ~/rilevation/$d
    cp /home/pi/co2-$o.txt ~/rilevation/$d

    echo "Saving files..."
    
    sleep 6m  #delay for the new detection

    rm /home/pi/temperature-$o.txt     #removing local files
    rm /home/pi/humidity-$o.txt
    rm /home/pi/co2-$o.txt
    
    echo "Deleting previous local detection..."

    sleep 2s

    sshpass -p <naopass> ssh <utente>@<naoip> "rm -rf <percorsoNao>/temperatura.txt"        #removing remote files
    sshpass -p <naopass> ssh <utente>@<naoip> "rm -rf <percorsoNao>/humidity.txt"
    sshpass -p <naopass> ssh <utente>@<naoip> "rm -rf <percorsoNao>/co2.txt"

    echo "Deleting previous remote detection..."

    sleep 3s

done

