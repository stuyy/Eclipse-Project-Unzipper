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

  #RUNNABLE_FILE_COUNT=$(grep -l 'void main' $(find */ -name "*.java") | wc -l) # This will return the number of files to be executed.
  counter=0
  # Loop through and get the next file to be executed.
  while [[ "$counter" = 0 ]];
  do

    #echo "Enter the name of the package"
    #read PACKAGE
    #java "$PACKAGE.$(grep -l 'void main' $(find */ -name "*.java") | xargs -L 1 basename | sed -n "$counter #p" | cut -f 1 -d '.')"
    EXECUTE_FILE # This will always guarantee it will run once.
    echo "Enter 1 to stop"
    read CHOICE
    if [[ "$CHOICE" != "1" ]];
    then
      EXECUTE_FILE # If they do not enter 1, then we continue to grade.

    else
      counter=$(($counter+1))
    fi
  done

}

EXECUTE_FILE()
{
  pwd
  echo "Enter the full name of the package"
  read PACKAGE
  echo $PACKAGE
  java "$PACKAGE.$(grep -l 'void main' $(find */ -name "*.java") | xargs -L 1 basename | sed -n "$lineCounter p" | cut -f 1 -d '.')" # Run the file.
  lineCounter=$(($lineCounter+1))
  return # Return.
}




echo "Welcome to Anson's Java Compiling Script. Please enter an existing file to extract"
read FILE
if [ -e "$FILE" ]; # If the file exists, we want to unzip it.
then
  unzip_FILE # Unzip the file.
  compile_FILE # Compile the java files in the project folder.
  #After compiling, go into the src folder.
  cd_src # At this point everything has been compiled. We just need to run the file.
  run_FILE
fi
cd -
rm -r */
#java $(grep -l 'void main' $(find . -name "*.java") | cut -f 2 -d '.')
