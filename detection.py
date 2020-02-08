import Adafruit_DHT as dht  #libreria dht22
import os   #libreria controllo dei file
import mh_z19   #libreria mhz19 (co2)

h,t = dht.read_retry(dht.DHT22, 4) #4 pin del raspberry
co2=mh_z19.read()                  #schema per la connessione salvato nei preferiti

temp=open("temperature.txt","w")       #scrittura della variabile t nel file temperatura
temp.write(repr(t))
temp.close()

hum=open("humidity.txt","w")        #scrittura della variabile h nel file umidità
hum.write(repr(h))
temp.close()

cco2=open("co2.txt","w")        #scrittura della variabile co2 nel file co2
cco2.write(repr(co2))
cco2.close()
