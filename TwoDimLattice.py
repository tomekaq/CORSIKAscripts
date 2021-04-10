# Tomasz Antonik 

########################################################
#
#	2D version checking only hit particle on x position
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
arrayWithYcoor = []     	        			# Creating the array with value of y coordinate    
 
print('Enter your min x of detectors:')
xmin= int(input())

print('Enter your min y of detectors:')
ymin= int(input())

print('Enter the number of detectors:')
n = int(input())

print('Enter your size of detector:')
d = int(input())

print('Enter your distance between detector:')
m = int(input())

for line in read_data:	
	try:					# reading line by line file with particle data 
		matchX = re.search(r'x=([+-]?[0-9]{1,15})',line) 
		arrayWithXcoor.append(matchX.group(0).strip("x="))
		matchY = re.search(r'y=([+-]?[0-9]{1,15})',line)
		arrayWithYcoor.append(matchY.group(0).strip("y="))
		continue		# parse line to select value of coordinate x
	except:
		print("Error match")	


###### Function below create lattice with n detector with m distance between them
###### in array "arrayOfDetector" there are store value of central point of detector

arrayOfDetectors = list(np.arange( xmin,xmin+n*m,m))  
arrayOfDetectorsOnY = list(np.arange( ymin,ymin+n*m,m) )


###### Function which creating area of detector

def sizeOfDetector(detektorN,widthOfDetector):					
	return (detektorN-widthOfDetector/2.0,detektorN+widthOfDetector/2.0)


def checkIfHit(coorOfParticle,detectorN):       		# function which check if  particle hit in area of detector n
	if (detectorN[0] <= float(coorOfParticle) and detectorN[1] >= float(coorOfParticle)):
		return 1
	return 0

global numberofHit

def main(arrayWithParticles,arrayOfDetectors):
	numberofHit = 0
	numberOfParticles = len(arrayWithParticles)
	lista = np.zeros((len(arrayOfDetectors),len(arrayWithParticles) ))
	for i in range(0,len(arrayWithParticles)):
		for n in range(0,len(arrayOfDetectors)):
			warunek = checkIfHit(arrayWithParticles[i], sizeOfDetector(arrayOfDetectors[n],d) ) 
			if (warunek == 1 ):   				# if particle hit one of detector there are counting as registered particle
				lista[n][i] = 1.0	
	return lista  

def compare(arr1,arr2):
	return np.logical_and(arr1, arr2)
		

def countHitInTwoDetector(arr):
	return np.count_nonzero(arr== 1)	
	

numberOfParticles = len(arrayWithXcoor)
numberOfRegisteredParticleOnX = main(arrayWithXcoor,arrayOfDetectors)
numberOfRegisteredParticleOnY = main(arrayWithYcoor,arrayOfDetectorsOnY)


print( "Total number of particle in shower:", numberOfParticles )
print( "Number of registered on X coor particle", np.count_nonzero( numberOfRegisteredParticleOnX == 1 ) )
print( "Number of registered on Y coor particle", np.count_nonzero( numberOfRegisteredParticleOnY == 1) )

numberOfRegistered = countHitInTwoDetector(compare ( numberOfRegisteredParticleOnX, numberOfRegisteredParticleOnY ) )
print( countHitInTwoDetector(compare ( numberOfRegisteredParticleOnX, numberOfRegisteredParticleOnY ) ))
print ( "Percent of registered particle: {:.2f}%".format( round ((numberOfRegistered / numberOfParticles) * 100.0) ,4 ) )  	# printing percent of registered particle

