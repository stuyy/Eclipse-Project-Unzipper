#!/bin/sh

echo "Welcome to Anson's Bash Script for compiling Java Eclipse projects.\n
Please specify the file you would like to extract and compile."

read FILE
echo $FILE

if [ -e $FILE ];
then
  echo "File exists. Extracting Files."
else
  echo "File does not exist."
fi
#mv ./*/src/*.java ./
#javac *.java
#java $(grep -l main *.java | cut -f 1 -d '.' | head -1)

#echo "End of test, Deleting files..."
#rm *.java *.class # Delete all the .java and .class files
#rm -r */ # Delete all directories in the current working directory.
