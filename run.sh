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
  return
}
run_FILE()
{

  echo "Enter the name of the package"
  read PACKAGE

  if [[ -z "${PACKAGE// }" ]]; # If no package is specified, then prompt the user for the name of the file.
  then

    echo "Enter the name of the file"
    read FILE
    java $FILE

  else
    echo "Enter the name of the file"
    read FILE
    java "$PACKAGE.$FILE"
  fi

  echo "Continue? y/n"
  read CHOICE
  if [[ "$CHOICE" = "y" || "$CHOICE" = "Y" ]];
  then
    run_FILE
  fi
  return
}

run_FILE2()
{
  echo "Enter the name of the executable java file WITHOUT the .java extension"
  read FILE
  # I will check if the source code has a main method, but for now we will assume it does.
  # Find the package.
  PACKAGE=$(grep 'package' "$(find . -name "$FILE.java")" -m 1 | awk '{print $2}' | tr -d ';' | tr -d '\r')
  COMPILE=$PACKAGE.$FILE
  echo $COMPILE
  java $COMPILE
  
}

# Start of the program
# There are a set of things this program MUST do, however I want to add flexible commands for the user.
# The user may want to get a list of packages, or the list of files that are executable.
# 
# 
#
#
#

echo "Welcome to Anson's Java Compiling Script. Please enter an existing file to extract"
read FILE
if [ -e "$FILE" ]; # If the file exists, we want to unzip it.
then
  unzip_FILE # Unzip the file.
  compile_FILE # Compile the java files in the project folder.
  #After compiling, some project files may have spaces in their name, we need to fix this. We can either remove the space, or just rename it to a constant name.
  mv */ TEST #Change the name of the directory to TEST.
  cd_src # Change the directory into the source folder.
  run_FILE2
fi
cd -
rm -r */
#java $(grep -l 'void main' $(find . -name "*.java") | cut -f 2 -d '.')
