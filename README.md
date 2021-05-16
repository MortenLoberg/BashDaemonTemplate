# Bash Daemon Template

A simple and easy to understand template for writing *systemd* based daemons in Bash-scripts (Bourne-Again SHell).

To daemonize your script, just add or source the functionality you need into the doCommands() function, adjust the basic settings of the daemon script like name of the daemon and time between iterations, and adjust the service script to your needs. See *DOCS.md* for installation details.

When the script is adapted to your needs, it is easily started and stopped with systemd service command (available on most Linux distributions). Long gone is the need to use crontab, and the template also supports automatic stop and start on computer/server halt and startup.

Commands to start/stop and view current status your daemon script:<br>
*NOTE: Depending on what your script is actually doing, you may need to run these commands with sudo.*<br>
```
systemctl start mybashdaemon       # start your bash daemon
systemctl stop mybashdaemon        # stop your bash daemon
systemctl status mybashdaemon      # display current status of your bash daemon
```

To automatically start your bash daemon on computer/server startup, simply *enable* it:<br>
```
systemctl enable mybashdaemon    # auto-starts your bash daemon on computer/server boot
systemctl disable mybashdaemon   # does not auto-start your bash daemon on computer/server boot
```
This is a test.

