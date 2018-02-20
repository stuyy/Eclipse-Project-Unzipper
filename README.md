# Anson's Bash Script for Compiling & Executing Eclipse Projects
![Image](https://fthmb.tqn.com/yOE1QoYZHEUhVkZuuxop_Ma9mQU=/768x0/filters:no_upscale()/Gnu-bash-logo.svg-58c6fe745f9b58af5c8d8017.png)

Users can extract an exported Eclipse Project (.zip) via the Mac Terminal and compile and run the project. A list of executable files are listed when the user specifies an argument. This currently is still in the works of testing for Linux, but it should work on the Mac Terminal.
# Getting Started
Download the file `run.sh` from this repository. Open up your terminal. Download an Eclipse Project. The Eclipse Project MUST be exported properly or else issues may arise. If you use this for grading, then have your students properly export the Eclipse Project.
I will implement a way to fix this in the future, but for now, make sure the Eclipse Projects are properly exported in a .zip format. You can set an alias to run the script a lot easier.
```
alias run='./run.sh'
```
Specify arguments in the format of: [NAME] [FILE]
Example:
```
run anson project1.zip
```
`NAME: Renames the directory to the argument`
`FILE: Name of the file to be imported`

# Requirements
Bash is required for this script to work. You must have `java`, `javac`, and `unzip` installed on your shell.

For Windows users, there are some tweaks that I made after running some tests. But the only difference is the top line where `#!/bin/sh` is located, simply replace it with `#!/bin/bash`. The script for the Windows version will be available.

# Options
The options are self explanatory when you run the script. There are 4 options that allow you to either run a file, list the files, view the output of the program, or end the script. 
