#!/bin/bash
# Tomasz Antonik

#  Program wczytuje dane odczytane przez program ./CorsikaRead i zapisuje je do pliku tekstowego.
#  W dalszej częsci będą one filtrowane. 
#  Następnie program rozdziela cząstki do mniejszego pliku zgodnie z podanymi przez użytkownika
#  parametrami położenia X i Y 

# Program reads data from ./CorsikaRead and writes it to new file.
# Then program reads .txt file and divines particle data to another, smaller .txt file.
#  according to the parameters given by the user

echo "Enter name of file to read in ./CorsikaRead"
read binaryInput

cd ~/Pulpit/corsika-77100/src/utils/coast/CorsikaRead 			# command to run CorsikaReader 
inpCorsika=$(./CorsikaReader binaryOutput)

#cd ~/Pulpit

touch CorsikaReadOutput.txt
echo "$outputCorsika" > CorsikaReadOutput.txt

echo "Enter name of file which will be read:"
read inputFile

i=0
input=$inputFile
patternid='[0-9]+'
patternX='x=([-+][0-9]+\.?[0-9]*)|x=([0-9]*\.[0-9]+)|x=([0-9]+)' 	#pattern of particle value of position X
patternY='y=([-+][0-9]+\.?[0-9]*)|y=([0-9]*\.[0-9]+)|y=([0-9]+)' 	#pattern of particle value of position y
patternE='e=*.[0-9]{0,7}.[0-9]{0,3}*'				 	#pattern of particle value of energy 
patternW='w=([-+][0-9]+\.?[0-9]*)|w=([0-9]*\.[0-9]+)|w=([0-9]+)' 	#pattern of particle value of W

echo "Enter name of file in which data will be saved:"
read writeFileData
touch $writeFileData

echo "Enter position X of particle greater than:"   
read gtX								# upper limit position X of particle
echo "Enter position X of particle less than:"
read ltX								# lower limit position X of particle
echo "Enter position Y of particle greater than:"
read gtY								# upper limit position Y of particle
echo "Enter position Y of particle less than:"
read ltY								# lower limit position Y of particle

############################################################################################################

while IFS= read -r line							# begining of reading loop 
do  
[[ $line =~ $patternX ]]                                		# pattern current particle with pattern of position X 
lessThanX=$(echo "${BASH_REMATCH[0]} > $gtX" | bc) 			# value of pattern X are compare with user parameter 
greaterThanX=$(echo "${BASH_REMATCH[0]} < $ltX" | bc)
if [[ $greaterThanX = '1' ]] && [[ $lessThanX = '1' ]]; 		# if value of position X are between user limit  
then
	
	[[ $line =~ $patternY ]]                			# pattern current particle with pattern of position Y  
	lessThanY=$(echo "${BASH_REMATCH[0]} > $gtY" | bc) 		# value of pattern Y are compare with user parameter 
	greaterThanY=$(echo "${BASH_REMATCH[0]} < $ltY" | bc)
	if [[ $greaterThanY = '1' ]] && [[ $lessThanY = '1' ]];		# if value of position X and Y are between user parameter particle is saving to file
	then 
		echo $line
		echo $line >> $writeFileData				# particle which are in middle are writing to the new file
		((i =i + 1))
	fi
fi
done < "$input" 
#echo "$i" 
