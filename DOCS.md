# Installation and setup instructions

## IMPORTANT NOTICE

Contributors are welcome to improve the template! However, please leave it as a template and nothing more. Secondly, if you clone the repository to your local computer, and make changes which you push back to the master repository, please be careful not to include your own personalized daemon script or functionality - this is a template and I wish to keep it like that.

## DISCLAIMER

Use at your own risk! Developers and contributors assume no liability and are not responsible for any misuse or damage caused by this template.

## 1. Clone the repository

Get a local clone:
```bash
cd ~
git clone https://github.com/MortenLoberg/BashDaemonTemplate.git BashDaemonTemplate.git         # clone this repository
```
Copy the template files:
```bash
cp BashDaemonTemplate.git/daemon_template.sh /opt/my_scripts/mysftpget_daemon.sh                # copy the main script template, for personalization 
cp BashDaemonTemplate.git/daemon_template.service /etc/systemd/system/mysftpget_daemon.service  # copy the service script template, for personalization 
```

## 2. Modify the service script

Modify the service script with your personalization, in particular the following lines (below is only an example):
```bash
...
Description=My SFTP-Get Daemon
...
ExecStart=/opt/my_scripts/mysftpget_daemon.sh
...
```

## 3. Modify the daemon script

Modify the daemon script with your personalization, in particular the following lines (below is only an example):
```bash
...
daemonName="mysftpget_daemon"
...
# NOTE: do NOT add slash (/) at end of paths, these are added by the script
logDir="/my_logs/mysftpget_daemon"
...
# NOTE: do NOT add slash (/) at end of paths, these are added by the script
localPath="/my_files/files_from_sftp"
...
doCommands() {
# This function runs the actual commands of the script
# Usage: doCommands "logfilepath-and-name.log" "whatever" "something" "..."
  local vLog="$1"
  local vRemotePath="$2"
  local vSSHKey="$3"
  local vServer="$4"
  #more parameters possible to add here, but more than 9 must be handled specifically

  # Add your commands here, i.e. what you want the daemon to do
  # Alternatively you may source separate script(s), 
  #    but recommend having ONLY functions in the sourced script(s)
  #    Source separate library script(s), and call functions like this:
  #source /path-to-your-script/name-of-function-library-with-unique-function-names.sh
  #myFunction1 "param1" "param2" "param3"   # calls/runs your function number one
  #myFunction2 "param1" "param2" "param3"   # calls/runs your function number two
  
**  cd "$localPath" >> /dev/null 2>&1
  exit_code_get=`echo mget $vRemotePath/* | sftp -i $vSSHKey $vServer >> /dev/null 2>&1 && echo 0 || echo 1`
  write_log "$vLog" "Finished with result=$exit_code_get"
**  
  # Best practice to return to root-folder after all commands
  cd / >> /dev/null 2>&1

  # normal function exit
  return 0
}
...
```

## 4. Test-run your script

Test-run your bash-script as follows (as a normal bash script first):
```bash
. /opt/my_scripts/mysftpget_daemon.sh
```

## 5. Test-run your script as a daemon

Start your daemon script as follows when you're sure all bugs are fixed (in some cases you may need to run this command with sudo):
```bash
systemctl start mysftpget_daemon
```

## 6. Check status and stop the daemon

Check the status of your daemon script as follows (in some cases you may need to run this command with sudo):
```bash
systemctl status mysftpget_daemon
```
Stop your daemon script as follows (in some cases you may need to run this command with sudo):
```bash
systemctl stop mysftpget_daemon
```
