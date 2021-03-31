#!/bin/bash

#cd ~/Pulpit/corsika-77100/src/utils/coast/CorsikaRead # command to run Corsika simulation
#inpCorsika=$(./CorsikaReader DAT000001.inclined)

cd ~/Pulpit
#touch outputCorsikaInclined.txt
#echo "$inpCorsika" > outputCorsikaInclined.txt
i=0
input="./outputCorsikaInclined.txt"
patternid='[0-9]+'
patternX='x=([-+][0-9]+\.?[0-9]*)|x=([0-9]*\.[0-9]+)|x=([0-9]+)'
patternY='y=([-+][0-9]+\.?[0-9]*)|y=([0-9]*\.[0-9]+)|y=([0-9]+)'
patternE='e=*.[0-9]{0,7}.[0-9]{0,3}*'
patternW='w=([-+][0-9]+\.?[0-9]*)|w=([0-9]*\.[0-9]+)|w=([0-9]+)'

touch > filtered.txt
while IFS= read -r line
do  
[[ $line =~ $patternid ]]
a=${BASH_REMATCH[0]}
j="10000.0"
k="-10000.0"
if [[ ${BASH_REMATCH[0]} -eq $1 ]]
then
   ((i = i+1)) 
    echo $line >> filtered.txt
fi
done < "$input" 
echo "$i"
