import Adafruit_DHT as dht
import os
import mh_z19

h,t = dht.read_retry(dht.DHT22, 4) #4 pin del raspberry
co2=mh_z19.read()

temp=open("temperature.txt","w")
temp.write(t)
temp.close()

hum=open("humidity.txt","w")
hum.write(h)
temp.close()

cco2=open("co2.txt","w")
cco2.write(co2)
cco2.close()
