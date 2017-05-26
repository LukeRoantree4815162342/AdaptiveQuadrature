
'''
You'll need to install a few python packages to run this; open a terminal
and enter 'sudo apt-get install python-pip' to get the package manager,
then enter 'pip install pyosc --pre'
That **should** be enough to get it working. To run it enter into the terminal 'python deleteMaeve.py'

Good Luck!
'''

import OSC
import random
import time
c = OSC.OSCClient()
c.connect(('127.0.0.1', 6448))   # change port to whatever Wekinator's listening on, this is the default port
while True:
    oscmsg = OSC.OSCMessage()
    oscmsg.setAddress("/wek/inputs")	# change to match 'input message' on wekinator, this is default
    for i in range(0,9):	# for 9 inputs
    	oscmsg.append(random.uniform(-12000,12000))	# any x for -12000 < x < 12000 as likely as any other, use
							# random.normal() instead if you want middle of range to be more likely
    c.send(oscmsg)
    time.sleep(1)	# refreshes every second; change to 0.1 for every 10th of a second etc.
