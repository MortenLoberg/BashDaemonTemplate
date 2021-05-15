# Bash Daemon Template

A simple and easy to understand template for writing systemd-based daemons in Bash-scripts (Bourne-Again SHell).

To daemonize your script, just add or source the functionality you need into the doCommands() function, adjust the basic settings of the daemon script like time between iterations, and adjust the service script to your needs. 

When the script is adapted to your needs, it is easily started and stopped with systemd service command (available on most Linux distributions). Long gone is the need to use crontab, and the template also supports automatic stop and start on computer/server halt and startup.

Commands to start/stop and view current status:
