#!/bin/bash
#  Autor: Tomasz Antonik

# Program do rozdzielania cząsstek wg ich ID
# Program wczytuje plik tekstowy z danymi i następnie rozdziela 
# dane do mniejszych plików według podanego przez użytkownia parametru 

#  Program read data from output of script txt 
#  and divide data according by user parameter 

i=0

echo "Enter the name of file read the data:"
read readFile

echo "Enter ID of particle to separate:"
read ID
input=$readFile
patternid='id: ([0-9]+)'

echo "Enter the name of file to which save the data:"
read fileID
> $fileID

while IFS= read -r line
do  
[[ $line =~ $patternid ]]
if [[ ${BASH_REMATCH[0]:3} -eq ID ]]
then
   ((i = i+1)) 
    echo $line >> $fileID
fi
done < "$readFile" 
echo "$i"
