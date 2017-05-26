import OSC
import random
import time
c = OSC.OSCClient()
c.connect(('127.0.0.1', 6448))   # connect to SuperCollider
while True:
    oscmsg = OSC.OSCMessage()
    oscmsg.setAddress("/wek/inputs")
    for i in range(0,9):
    	oscmsg.append(random.uniform(-12000,12000))
    c.send(oscmsg)
    time.sleep(1)
