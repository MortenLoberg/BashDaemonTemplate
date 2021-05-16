# Bash Daemon Template

<a href="https://www.buymeacoffee.com/mortenloberg" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 30px;" ></a>

## Test another

![Buy Me A Coffee]<img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" width="50%" height="50%">

A simple and easy to understand template for writing ***systemd*** based daemons in Bash-scripts (Bourne-Again SHell).

To daemonize your script, just add or source the functionality you need into the doCommands() function, adjust the basic settings of the daemon script like name of the daemon and time between iterations, and adjust the service script to your needs. See [DOCS.md](https://github.com/MortenLoberg/BashDaemonTemplate/blob/master/DOCS.md) for installation details.

Long gone is the need to use crontab, and complicated runlevel setups for automatic start and stop on computer/server boot and halt, respectively.

## What is *systemd*?

This article <https://www.linode.com/docs/guides/start-service-at-boot/> explains it as follows (this is a brief extract, I recommend reading the full article):
> *"systemd is a Linux system tool initially developed by the Red Hat Linux team. It includes many features, including a bootstrapping system used to start and manage system processes. It is currently the default initialization system on most Linux distributions. Many commonly used software tools, such as SSH and Apache, ship with a systemd service."*

## What *systemd* commands are available?

When the script is adapted to your needs, all ***systemd*** service commands are available at your fingertips.

Your bash daemon is easily started and stopped using the commands below, and it's equally easy to get the current status of your daemon script:  
*NOTE: Depending on what your script is actually doing, you may need to run these commands with **sudo**.*

```bash
systemctl start mybashdaemon     # starts your bash daemon
systemctl stop mybashdaemon      # stops your bash daemon
systemctl restart mybashdaemon   # restarts your bash daemon
systemctl status mybashdaemon    # displays the current status of your bash daemon
```

To get your daemon to start automatically on computer/server boot, simply *enable* it:

```bash
systemctl enable mybashdaemon    # auto-starts your bash daemon on computer/server boot
systemctl disable mybashdaemon   # does not auto-start your bash daemon on computer/server boot
```

## License

MIT License

Copyright (c) 2021 Morten Løberg

See further license details in [LICENSE.md](https://github.com/MortenLoberg/BashDaemonTemplate/blob/master/LICENSE.md).
