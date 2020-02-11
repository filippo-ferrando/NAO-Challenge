#! /bin/bash

#sshpass -p <naopass> ssh <utente>@<naoip>

echo "Starting Daemon" | figlet #only a cool start

#reverse shell for emergency connection, if it will not find any connection, it will pass over

echo "Attempt reverse shell"
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1 | nc <ipPcEmergenza> 4444 -q 10 > /tmp/f  #work-around for netcat -e option

sleep 10s

#cicle for sending saving and removing file (it also run the py script for retrive data)

while true; do

    #creazione variabile con data corrente(yyyy-mm-dd)
    d=$(date -I)
    #creazione variabile con ora (hh-mm)
    o=$(date +%R)

    python detection.py #retrive data from sensor
    
    echo "detection..."

    sleep 1m  #security of data presence delay

    sshpass -p <naopass> scp /home/pi/temperature.txt <user>@<ipnao>:<percorsoMemoriaNao>/temperature.txt       #sending over ssh protocol temp, humdity and co2 files
    sshpass -p <naopass> scp /home/pi/humidity.txt <user>@<ipnao>:<percorsoMemoriaNao>/humidity.txt
    sshpass -p <naopass> scp /home/pi/co2.txt <user>@<ipnao>:<percorsoMemoriaNao>/co2.txt
    
    echo "Sending files in progress..."

    sleep 3s

    #controllo se la cartella con la data esiste, se no la creo
    if [ -d $d ]; then
        echo "la cartella esiste già"
    else
        mkdir $d
    fi

    #rinomino i file delle misurazioni aggiungendo l'ora
    mv /home/pi/temperature.txt /home/pi/temperature-$o.txt
    mv /home/pi/humdity.txt /home/pi/humdity-$o.txt
    mv /home/pi/co2.txt /home/pi/co2-$o.txt

    #copio i file rinominati nella cartella con la data
    cp -r /home/pi/temperature-$o.txt /home/pi/rilevation/$d    #saving file in archive directory
    cp -r /home/pi/humidity-$o.txt /home/pi/rilevation/$d
    cp -r /home/pi/co2-$o.txt /home/pi/rilevation/$d

    echo "Saving files..."
    
    sleep 6m  #delay for the new detection

    #controllo se la cartella con la data esiste, se no la creo
    if [ -d $d ]; then
        echo "la cartella esiste già"
    else
        mkdir $d
    fi

    #rinomino i file delle misurazioni aggiungendo l'ora
    mv /home/pi/temperature.txt /home/pi/temperature-$o.txt
    mv /home/pi/humdity.txt /home/pi/humdity-$o.txt
    mv /home/pi/co2.txt /home/pi/co2-$o.txt

    #copio i file rinominati nella cartella con la data
    cp -r /home/pi/temperature-$o.txt /home/pi/rilevation/$d    #saving file in archive directory
    cp -r /home/pi/humidity-$o.txt /home/pi/rilevation/$d
    cp -r /home/pi/co2-$o.txt /home/pi/rilevation/$d

    echo "Saving files..."

    sleep 6s

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

