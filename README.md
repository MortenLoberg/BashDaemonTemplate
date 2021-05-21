# Bash Daemon Template

<a href="https://www.buymeacoffee.com/mortenloberg" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="20%"/></a>

This is an easy to understand template for writing ***systemd*** based daemons in Bash-scripts (Bourne-Again SHell).

To daemonize your script follow the instructions in [DOCS.md](https://github.com/MortenLoberg/BashDaemonTemplate/blob/master/DOCS.md).

Long gone is the need to use crontab (which by the way is still good to use for particular usage), and complicated runlevel setups for automatic start and stop on computer/server boot and halt, respectively.

## What is *systemd*?

This article at [Linode](https://www.linode.com/docs/guides/start-service-at-boot/) explains it as follows (this is a brief extract, I recommend reading the full article):
> *"systemd is a Linux system tool initially developed by the Red Hat Linux team. It includes many features, including a bootstrapping system used to start and manage system processes. It is currently the default initialization system on most Linux distributions. Many commonly used software tools, such as SSH and Apache, ship with a systemd service."*

And on the [project web page](https://systemd.io/) they write:
> *"systemd is a suite of basic building blocks for a Linux system. It provides a system and service manager that runs as PID 1 and starts the rest of the system. systemd provides aggressive parallelization capabilities, uses socket and D-Bus activation for starting services, offers on-demand starting of daemons, keeps track of processes using Linux control groups, maintains mount and automount points, and implements an elaborate transactional dependency-based service control logic. systemd supports SysV and LSB init scripts and works as a replacement for sysvinit. Other parts include a logging daemon, utilities to control basic system configuration like the hostname, date, locale, maintain a list of logged-in users and running containers and virtual machines, system accounts, runtime directories and settings, and daemons to manage simple network configuration, network time synchronization, log forwarding, and name resolution."*

So ***systemd*** is a System and Service Manager, and it is implemented/available on many Linux distro's out there, like (this is not necessarily a complete list): RHEL, Fedora, Debian, Ubuntu, openSUSE, Arch Linux, Mageia and Gentoo.

That's all very good, but the best part (at least in my opinion) is that it supports implementing user-written daemons, and quite easily!

Note that the Bash Daemon Template available in this repository, and it's documentation, assumes it is installed by a system administrator as it is a system-wide daemon (i.e. running independently from the user starting it). However, it shouldn't be too tricky to adapt it to run in systemd user mode. If that's what you want/need, perhaps the article [systemd/User - ArchWiki](https://wiki.archlinux.org/title/Systemd/User#How_it_works) is a good place to start.

## Which *systemd* commands are available?

When the script is adapted to your needs, all ***systemd*** service commands are available at your fingertips.

Your bash daemon is easily started and stopped using the commands below, and it's equally easy to get the current status of your daemon (*NOTE: Depending on what your script is actually doing, you may need to run these commands with **sudo**.*):

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

Run "*man systemctl*" to read which other ***systemd*** service commands are available.

## How to get started?

Read details in [DOCS.md](https://github.com/MortenLoberg/BashDaemonTemplate/blob/master/DOCS.md) with regards to how to install and set up your first bash daemon.

## License

MIT License

Copyright (c) 2021 Morten Løberg

See further license details in [LICENSE.md](https://github.com/MortenLoberg/BashDaemonTemplate/blob/master/LICENSE.md).
