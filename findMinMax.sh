#!/bin/bash
#  Autor: Tomasz Antonik

#  Program wczytuje dane odczytane i znajduje maksymalne i minimalne wartosci z danych
#  Script to find maximum and minimum value of data from file readed by ./CorsikaRead

i=0

echo "Enter name of file which will be read:"
read inputFile

input=$inputFile
patternX='x=([-+][0-9]+\.?[0-9]*)|x=([0-9]*\.[0-9]+)|x=([0-9]+)' 	#pattern
patternY='y=([-+][0-9]+\.?[0-9]*)|y=([0-9]*\.[0-9]+)|y=([0-9]+)' 
patternE='e=([-+][0-9]+\.?[0-9]*)|e=([0-9]*\.[0-9]+)|e=([0-9]+)'
patternW='w=([-+][0-9]+\.?[0-9]*)|w=([0-9]*\.[0-9]+)|w=([0-9]+)'

maxX=-10000000
minX=100000000
maxY=-10000000
minY=100000000
maxE=-10000000
minE=100000000
maxW=-10000000
minW=100000000

while IFS= read -r line
do  
 (( i = i+1 ))  
[[ $line =~ $patternX ]]
if [[ 1 -eq "$(echo "${BASH_REMATCH[0]:2} > $maxX" |bc )" ]]
	then
	maxX=${BASH_REMATCH[0]:2} 
fi

[[ $line =~ $patternX ]]
if [[ 1 -eq "$(echo "${BASH_REMATCH[0]:2} < $minX" |bc )" ]]
	then
	minX=${BASH_REMATCH[0]:2} 
fi

[[ $line =~ $patternY ]]    
if [[ 1 -eq "$(echo "${BASH_REMATCH[0]:2} > $maxY" |bc )" ]]
	then
	maxY=${BASH_REMATCH[0]:2} 
fi

[[ $line =~ $patternY ]]
if [[ 1 -eq "$(echo "${BASH_REMATCH[0]:2} < $minY" |bc )" ]]
	then
	minY=${BASH_REMATCH[0]:2} 
fi

[[ $line =~ $patternE ]]
if [[ 1 -eq "$(echo "${BASH_REMATCH[0]:2} > $maxE" |bc )" ]]
	then
	maxE=${BASH_REMATCH[0]:2} 
fi
[[ $line =~ $patternE ]]
if [[ 1 -eq "$(echo "${BASH_REMATCH[0]:2} < $minE" |bc )" ]]
	then
	minE=${BASH_REMATCH[0]:2} 
fi

[[ $line =~ $patternW ]]
if [[ 1 -eq "$(echo "${BASH_REMATCH[0]:2} > $maxW" |bc )" ]]
	then
	maxW=${BASH_REMATCH[0]:2} 
fi
[[ $line =~ $patternW ]]
if [[ 1 -eq "$(echo "${BASH_REMATCH[0]:2} < $minW" |bc )" ]]
	then
	minW=${BASH_REMATCH[0]:2} 
fi
done < "$input" 

echo "Enter name of file in which statistic will be saved:"
read nameInfoFile
touch $nameInfoFile
echo "Date of operation: $(date)" 
echo "Dane z pliku:  $nameInfoFile" >> $nameInfoFile
echo $(date) >> $nameInfoFile
echo "Number of particle: $i" >> $nameInfoFile
echo "Minimum Value X: $minX" >> $nameInfoFile
echo "Maximum Value X: $maxX" >> $nameInfoFile
echo "Minimum Value Y: $minY" >> $nameInfoFile
echo "Maximum Value Y: $maxY" >> $nameInfoFile
echo "Minimum Value E: $minE" >> $nameInfoFile
echo "Maximum Value E: $maxE" >> $nameInfoFile
echo "Minimum Value W: $minW" >> $nameInfoFile
echo "Maximum Value W: $maxW" >> $nameInfoFile

