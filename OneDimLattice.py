# Tomasz Antonik 

########################################################
#
#	1D version checking only hit particle on x position
# 	Program read .txt file with data from Corsika simulation 
# 	and  test that particle with coordinate x, hit detector. 
# 	In program there are simulation n detector equally deployed 
# 	on one dimention lattice with this same size and same distance 
#	betweem them. 
#	User can enter value of:
#	1. amount of detector in lattice,
#	2. set position of first detectors,
#	3. value of distance between detectors,
#	4. width of detectors 
#
#######################################################

import numpy as np
from numpy.lib import recfunctions
import re

###### Section with reading the date 

f = open(input('Enter name with data:'), 'r')
read_data = f.readlines()

##### Section with patten matching data from Corsika

arrayWithXcoor = []     	        			# Creating the array with value of x coordinate     
for line in read_data:						# reading line by line file with particle data 
	match = re.search(r'x=([0-9]{1,10})',line) 		# parse line to select value of coordinate x
	arrayWithXcoor.append(match.group(0).strip("x="))	


print('Enter your min x of detectors:')
xmin= int(input())

#xmin =647255

#print('Enter your max x of detectors:')
#xmax= input()

print('Enter the number of detectors:')
n = int(input())

print('Enter your size of detector:')
d = int(input())

print('Enter your distance between detector:')
m = int(input())


###### Function below create lattice with n detector with m distance between them
###### in array "arrayOfDetector" there are store value of central point of detector

arrayOfDetector = np.arange( xmin,xmin+n*m,m)     	 

def sizeOfDetektor(detektorN,widthOfDetector):
	return (detektorN-widthOfDetector/2.0,detektorN+widthOfDetector/2.0)

def checkIfHit(xOfParticle,detectorN):       		# function which check if  particle hit in area of detector n
	if (detectorN[0] < xOfParticle and detectorN[1] > xOfParticle):
		return 1
	return 0

global numberofHit

#d=100
def main(arrayWithParticles):
	numberofHit = 0
	numberOfParticles = len(arrayWithParticles)
	lista = np.zeros((len(arrayOfDetector),len(arrayWithParticles) ))	
					
	for n in range(1,len(arrayOfDetector)):
		for i in arrayWithXcoor:					 
			lista[n][arrayWithXcoor.index(i)] = checkIfHit(int(i), sizeOfDetektor(arrayOfDetector[n],d) ) 
			if (checkIfHit(int(i), sizeOfDetektor(arrayOfDetector[n],d) ) ):      		 
				numberofHit+=1									# if particle hit one of detector there are counting as registered particle
	return numberofHit

numberOfParticles = len(arrayWithXcoor)
numberOfRegisteredParticle = main(arrayWithXcoor)


print( "Total number of particle in shower", numberOfParticles )
print( "Number of registered particle", numberOfRegisteredParticle )
print ( "Percent of registered particle: {:.2f}%".format( round ((numberOfRegisteredParticle / numberOfParticles) * 100) ,4 ) )  						# printing percent of registered particle

