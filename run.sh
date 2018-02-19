#!/bin/sh
COMMANDS=(" (1)List Executable Files\n" "(2)Execute a File\n" "(3)View Output\n" "(4)End")

unzip_FILE() # Call this function if the user specifies arguments in the beginning.
{
  unzip $2 >> log_output.txt
  echo "Extraction Successful... [$(date)]" 1>>log_output.txt
  mv */ $1
  return
}

unzip_FILE_TWO() # Call this function if the user does not specify any arguments.
{ 
  unzip $FILE
  mv */ $NAME
  return
}

compile_FILE()
{
  javac $(find */ -name "*.java")
  echo "Compile Successful... [$(date)]" 1>> log_output.txt
  return
}

cd_src() # cd to the source folder.
{
  cd */src
  return
}

run_FILE()
{
  echo "Enter the name of the executable java file WITHOUT the .java extension"
  read FILE
  # I will check if the source code has a main method, but for now we will assume it does.
  # Find the package.
  PACKAGE=$(grep 'package' "$(find . -name "$FILE.java")" -m 1 | awk '{print $2}' | tr -d ';' | tr -d '\r')
  COMPILE=$PACKAGE.$FILE
  #echo $COMPILE
  echo "Running $FILE.java\n" >> fileOutput.txt
  java $COMPILE >> fileOutput.txt
  echo "\n" >> fileOutput.txt
  return
}

# Start of the program
# There are a set of things this program MUST do, however I want to add flexible commands for the user.
# The user may want to get a list of packages, or the list of files that are executable.

userCHOICE()
{
  echo "What do you want to do?"
  echo "${COMMANDS[*]}"
  read CHOICE
  if [[ "$CHOICE" = 1 ]]; # If they enter 1, list all of the files that have a main method
  then
   targets=$(grep -l 'void main' $(find . -name "*.java") |  xargs -L 1 basename)
   echo $targets
   userCHOICE

  elif [[ "$CHOICE" = 2 ]];
  then
    run_FILE
    userCHOICE

  elif [[ "$CHOICE" = 3 ]];
  then

    outputFile=$(find . -name "fileOutput.txt")
    if [ -e "$outputFile" ];
    then
      cat $outputFile
      userCHOICE

    else
      echo "File not found"
      userCHOICE
    fi

  elif [[ "$CHOICE" = 4 ]];
  then
    return
  fi

}
# Everything here is global.
# Beginning of the file.
if [[ "$#" > 1 ]]; # It's greater than 0 if they enter in more than one argument. They entered a name.
then
# The first argument is a name.
  if [ -e "$2" ];
  then
    unzip_FILE $1 $2
    compile_FILE
    cd_src
    userCHOICE
    cd -
    rm -r */
  else
  echo "File not found."
  echo "Usage: [NAME] [FILE]"
  echo "name: Specify a name for the folder for the file to be extracted to."
  echo "name must not have any spaces and should only be one word."
  fi

elif [[ "$#" = 0 ]];
then

  echo "Welcome to Anson's Java Executable Script. Please enter an existing file to extract"
  read FILE
  echo "Enter name"
  read NAME

  if [ -e "$FILE" ]; # If the file exists, we want to unzip it.
  then
    unzip_FILE_TWO $FILE $NAME # Unzip the file.
    compile_FILE # Compile the java files in the project folder.
    #After compiling, some project files may have spaces in their name, we need to fix this. We can either remove the space, or just rename it to a constant name.

    cd_src # Change the directory into the source folder.
    userCHOICE
    #run_FILE2
    cd -
    rm -r */ 
  else
  echo "Usage: [NAME] [FILE]"
  echo "name: Specify a name for the folder for the file to be extracted to."
  echo "name must not have any spaces and should only be one word."
fi

elif [[ "$#" = 1 ]];
then
  echo "Usage: [NAME] [FILE]"
  echo "name: Specify a name for the folder for the file to be extracted to."
  echo "name must not have any spaces and should only be one word"
fi # End of if statement.
 
#java $(grep -l 'void main' $(find . -name "*.java") | cut -f 2 -d '.')


#user_id
#password