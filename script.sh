#!/bin/sh

echo "Welcome to Anson's Bash Script for compiling Java Eclipse projects.\n
Please specify the file you would like to extract and compile."

read FILE
echo $FILE

if [ -e $FILE ];
then
  echo "File exists. Extracting Files."
  unzip $FILE #Unzip the file.
  mv $(find . -name "*.java") ./ # Move all the java files to the cwd.
  sed -ie '\|com.ualbany|d' *.java
  javac *.java
  fileCount=$(grep -l 'void main' *.java | cut -f 1 -d '.' | wc -l)
  echo $fileCount
  counter=1
  while [[ "$counter" -le "$fileCount" ]];
  do
    java $(grep -l 'void main' *.java | cut -f 1 -d '.' | sed -n "$counter p")
    counter=$(($counter+1))
  done
  #java $(grep -l main *.java | cut -f 1 -d '.' | head -1)
  echo "End of test, Deleting files..."
  rm *.java *.class *.javae # Delete all the .java and .class files
  rm -r */ # Delete all directories in the current working directory.
else
  echo "File does not exist."
fi
