#!/bin/sh

lineCounter=1
unzip_FILE()
{
  unzip $FILE
  echo "Extraction Successful... [$(date)]" 1>>log_output.txt
  return
}

compile_FILE()
{
  javac $(find */ -name "*.java")
  echo "Compile Successful... [$(date)]" 1>> log_output.txt
  return
}

cd_src()
{
  cd */src
  pwd
  echo "Here"
  return
}
run_FILE()
{
  echo "Enter the name of the package"
  read PACKAGE
  echo "Enter the name of the file"
  read FILE
  java "$PACKAGE.$FILE"
  echo "Continue? y/n"
  read CHOICE
  if [[ "$CHOICE" = "y" || "$CHOICE" = "Y" ]];
  then
    run_FILE
  fi
  return
}

echo "Welcome to Anson's Java Compiling Script. Please enter an existing file to extract"
read FILE
if [ -e "$FILE" ]; # If the file exists, we want to unzip it.
then
  unzip_FILE # Unzip the file.
  compile_FILE # Compile the java files in the project folder.
  #After compiling, go into the src folder.

  cd_src # At this point everything has been compiled. We just need to run the file.
  # I want the user to enter the name of the file they're compiling.
  run_FILE
  
fi
cd -
rm -r */
#java $(grep -l 'void main' $(find . -name "*.java") | cut -f 2 -d '.')
