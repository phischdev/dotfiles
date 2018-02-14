#!/usr/bin/env python3
import subprocess
import time
 
def list():
	lights = subprocess.run(["xbacklight", "-list"], stdout=subprocess.PIPE).stdout
	lights = lights.decode('UTF-8')
	lights = str.split(lights, '\n')
	return lights 

def set(light, on):
	perc = 100 if on else 0
	subprocess.call(["xbacklight", "-ctrl", light,  str(perc)])

def blink(lights):
	flip = True
	while(True):
		for light in lights:
			light = light.rstrip()
			set(light, flip)
			time.sleep(0.1)
		flip = not flip
		#print("round", flip)
		time.sleep(0.5)	
