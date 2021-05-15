# Bash Daemon Template

A simple and easy to understand template for writing systemd-based daemons in Bash-scripts (Bourne-Again SHell).

To daemonize your script, just add or source the functionality you need into the doCommands() function, adjust the basic settings of the daemon script like time between iterations, and adjust the service script to your needs. 

When the script is adapted to your needs, it is easily started and stopped with systemd service command (available on most Linux distributions). Long gone is the need to use crontab, and the template also supports automatic stop and start on computer/server halt and startup.

Commands to start/stop and view current status:
```
# Depending on what your script is actually doing, you may need to run these commands with sudo
systemctl start mydaemonscript.sh          # start the daemon script
systemctl stop mydaemonscript.sh           # stops the daemon script
systemctl status mydaemonscript.sh         # shows the current status of the daemon script
```

To ensure your script is started on computer/server startup, you need to enable it:
```
systemctl enable mydaemonscript.sh         # starts the daemon script automatically on computer/server startup
systemctl disable mydaemonscript.sh        # does not start the daemon script automatically on computer/server startup
```

