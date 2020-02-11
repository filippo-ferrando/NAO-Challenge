import Adafruit_DHT as dht  #lib dht22
import os   #lib file control
import mh_z19   #lib mhz19 (co2)

h,t = dht.read_retry(dht.DHT22, 4) #pin of rasp
co2=mh_z19.read()                  #schema for connection bookmarked

temp=open("temperature.txt","w")       #write t variable in temperature.txt file
temp.write(repr(t))
temp.close()

hum=open("humidity.txt","w")        #write h variable in humidity.txt file
hum.write(repr(h))
hum.close()

cco2=open("co2.txt","w")        #write co2 variable in co2.txt file
cco2.write(repr(co2))
cco2.close()
