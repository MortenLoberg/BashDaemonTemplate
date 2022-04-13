#!/bin/bash

###############################################################################
# DISCLAIMER:
#   THIS SCRIPT IS 
#
#   THIS SCRIPT ORIGINATES FROM:
#       https://github.com/MortenLoberg/BashDaemonTemplate/daemon_template.sh
###############################################################################
# Script name:  daemon_template.sh
# Location:     /path-of-your-bash-script/
# Description:  Main part of the daemon bash template script
# Requires:     List any library scripts that needs to be sourced here
# Created by:   Name-Of-Author / Name-of-project / Name-of-company
# Date created: Insert creation date here
# Changes: 
#     Date-of-change    Changed-by    Brief description of change
#     ...
#     ...
#
###############################################################################
# Config-secion of the daemon script
#    This is where you put your configuration, in form of constants/variables
###############################################################################

# core config variables
#    These are required by Support functions - don't change their names
# don't use daemonName=`basename "$0"`, tricky when used with systemd
daemonName="daemon_template"        # what you want your daemon to be named
runInterval=300                     # sleep time in seconds between each run, recommend >= 60

# log file specs
# NOTE: do NOT add slash (/) at end of paths, these are added by the script
logDir="/log-path"                                  # path of log file
#logFileName="$daemonName-"`date +"%Y-%m-%d"`".log" # don't use! - tricky to use dated log files w/exitDaemon()
logFileName="$daemonName.log"                       # use a fixed log file name to ensure exitDaemon() works
logFile="$logDir/$logFileName"                      # full path and name of log file
logMaxSize=1024                                     # Log maxsize in KB before rotation, recommend 1024=1 MB

# other config variables - put your main path variables here
# NOTE: do NOT add slash (/) at end of paths, these are added by the script
localPath="/any-path/example-subFolder"             # example path variable

# Setting up trap for the systemd stop signal
#    exitDaemon() function writes to the log when systemd sends a stop-signal
trapcmd='exitDaemon "'$logFile'" "'$daemonName'"'
trap "$trapcmd" SIGTERM

###############################################################################
# Support functions of the daemon script - PART 1
#    It should not be necessary to change anything in this block
###############################################################################
write_log() {
# Log function - writes whole lines to the logfile
# usage: write_log "/path-to-logfile/logfile_name.log" "message to write to log"
  local vlog="$1"
  local vmsg="$2"

  # Exit function w/exit code 1 if no message OR no log-file is specified
  if [ -z "$vlog" ] || [ -z "$vmsg" ]; then
    return 1
  fi

  # Log message to the logfile
  echo `date +"%Y-%m-%d %T"`" $vmsg" >> "$vlog"

  # Exit function w/exit code 0 (normal exit)
  return 0
}

write_log_nol() {
# Log function with no new-line
# usage: write_log_nol "/path-to-logfile/logfile_name.log" "message to write to log"
  local vlog="$1"
  local vmsg="$2"

  # Exit function w/exit code 1 if no message OR no log-file is specified
  if [ -z "$vlog" ] || [ -z "$vmsg" ]; then
    return 1
  fi

  # Log message to the logfile w/o new-line at end
  echo -n `date +"%Y-%m-%d %T"`" $vmsg" >> "$vlog"

  # Exit function w/exit code 0 (normal exit)
  return 0
}

write_log_nod() {
# Log function with no date
# usage: write_log_nod "/path-to-logfile/logfile_name.log" "message to write to log"
  local vlog="$1"
  local vmsg="$2"

  # Exit function w/exit code 1 if no message OR no log-file is specified
  if [ -z "$vlog" ] || [ -z "$vmsg" ]; then
    return 1
  fi

  # Log message to the logfile w/o date in beginning of line
  echo "$vmsg" >> "$vlog"

  # Exit function w/exit code 0 (normal exit)
  return 0
}

###############################################################################
# Main function of the daemon script
#    This is where you put the functionality of your daemon, 
#    i.e. what you want the daemon to do 
###############################################################################
doCommands() {
# This function runs the actual commands of the script
# Usage: doCommands "logfilepath-and-name.log" "whatever" "something" "..."
  local vlog="$1"
  local vp1="$2"
  local vp2="$3"
  local vp3="$4"
  #more parameters possible to add here, but more than 9 must be handled specifically

  # Add your commands here, i.e. what you want the daemon to do
  # Alternatively you may source separate script(s), 
  #    but recommend having ONLY functions in the sourced script(s)
  #    Source separate library script(s), and call functions like this:
  #source /path-to-your-script/name-of-function-library-with-unique-function-names.sh
  #myFunction1 "param1" "param2" "param3"   # calls/runs your function number one
  #myFunction2 "param1" "param2" "param3"   # calls/runs your function number two

  # Best practice to return to root-folder after all commands
  cd / >> /dev/null 2>&1

  # normal function exit
  return 0
}

###############################################################################
# Support functions of the daemon script - PART 2
#    It should not be necessary to change anything in this block
###############################################################################
checkLogSize() {
# Check if necessary to rotate logfile
# usage: checkLogSize "/path-to-logfile/logfile_name.log" "1024"

  # Set the parameters given to local variables
  local vlog="$1"
  local vlogMaxSize="$2"
  local vsize=0

  # Return with exit code 1 if no logfile is specified
  if [ -z "$vlog" ] || [ -z "$vlogMaxSize" ]; then
    echo "ERROR in checkLogSize(): Wrong or missing function parameters!"
    return 1
  fi

  # Check if necessary to rotate logfile
  vsize=$((`ls -l "$vlog" | cut -d " " -f 5`/1024))
  if [[ $vsize -gt $vlogMaxSize ]]; then
    mv "$vlog" "$vlog."`date +"%Y-%m-%d"` >> /dev/null 2>&1
    touch "$vlog" >> /dev/null 2>&1
    write_log "$vlog" "***** The log-file was rotated."
  fi

  # Normal exit from function
  return 0
}

setupDaemon() {
# setup folder and file for logging - to be called absolutely first
# usage: setupDaemon "/path-to-logfile" "logfile_name.log"
  local vlogDir="$1"
  local vlogFile="$2"

  # Exits with with exit code 1 if logDir AND/OR logFile params are missing
  if [ -z "$vlogDir" ] || [ -z "$vlogFile" ]; then
    echo "ERROR in setupDaemon(): Wrong or missing function parameters! Must exit!"
    exit 1
  fi

  # Make sure that the log folder and file exists
  if [ ! -d "$vlogDir" ]; then
    mkdir "$vlogDir" >> /dev/null 2>&1
  fi
  cd $vlogDir/ >> /dev/null 2>&1
  if [ ! -f "$vlogFile" ]; then
    touch "$vlogFile" >> /dev/null 2>&1
  fi

  # Best practice to return to root-folder
  cd / >> /dev/null 2>&1

  # normal exit
  return 0
}

loop() {
# Loop function to call from bottom of daemon script
# Usage: loop "param1" "param2" "etc..."
#    Must include minimum the params required by the doCommands function
#    Alternatively use global variables, as long as these are used in the same script

  # Set local variables equal to the parameters
  local vlog="$1"
  local vp1="$2"
  local vp2="$3"
  local vp3="$4"
  #more parameters possible to add here, but more than 9 must be handled specifically

  # Some other local values that we need in the loop-function
  local vcntLoops=0
  local vmaxLoopsPerMsg=10     # just a default value

  # Exit with exit code 1 if any parameters are missing
  if [ -z "$vlog" ] || [ -z "$vp1" ] || [ -z "$vp2" ]; then
    echo "ERROR in loop(): Wrong or missing function parameters! Must exit!"
    exit 1
  fi

  # setting number of loops between each log-message to confirm process is alive
  let "vmaxLoopsPerMsg=3600/runInterval"

  while true; do
    # Set the current time (for start of current loop)
    startLoop=`date +%s`

    # Do everything you need the daemon to do
    doCommands "$vlog" "$vp1" "$vp2" ...
    afterWork=`date +%s`                 # clock time when work is finished
    procTime=$((afterWork-startLoop))    # calc. seconds the work took

    # Calc how long time to sleep for. If we want this to run once a minute
    # and it has taken more than a minute, then we just run it directly
    # (i.e. then we just sleep for 1 second)
    sleepTime=1
    if [[ $((procTime)) -lt $((runInterval)) ]]; then
      sleepTime=$((runInterval-procTime))
    fi

    # Time for a sleep
    sleep $((sleepTime))

    # Increment the iteration counter, and give a message
    # approximately every hour (good if nothing to do and nothing is written to logfile)
    let "vcntLoops+=1"
    if [[ $((vcntLoops)) -ge $((vmaxLoopsPerMsg)) ]]; then
      write_log "$vlog" "  *   Daemon is still alive."
      let "vcntLoops=0"
    fi

    # Check to see if we need to rotate the logs
    checkLogSize "$vlog" "$vlogMaxSize"
  done

  # normal function exit
  return 0
}

exitDaemon() {
# This is the exit function that is trapped/called on SIGTERM. 
#     When operator issue "systemctl stop" command the Systemd service sends the SIGTERM
#     signal to this daemon process (i.e. this script), and this function is called.
#     Rememeber to include clean-up code and log a message to the log-file.

  local vlog="$1"
  local vdaemonName="$2"
  local vmsg="***** Systemd service stopped $vdaemonName"

  echo `date +"%Y-%m-%d %T"`" $vmsg" >> "$vlog"     # do not call write_log() here!

  exit 0  # Exit 0 for a proper exit of the daemon process!
}

###############################################################################
# Commands to start the daemon
###############################################################################

# Best practice to start on root-folder
cd / >> /dev/null 2>&1

# Making sure log-folder and log-file exists
# Must keep this!
setupDaemon "$logDir" "$logFileName"

# Writing start information to the log
# Nice to log that the daemon has started
write_log "$logFile" "***** Systemd service started $daemonName"

# Start the daemon loop
# Adjust the loop function wrt. which parameters you need/want to send to it
# Must include minimum the params required by the doCommands function, 
#    unless global params are used within - below is an example - you probably need more
loop "$logFile" "$logMaxSize" "$runInterval"

exit 0
