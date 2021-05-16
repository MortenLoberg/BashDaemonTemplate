# Installation and setup instructions

## IMPORTANT NOTICE

Contributors are welcome to improve the template! However, please leave it as a template and nothing more. Secondly, if you clone the repository to your local computer, and make changes which you push back to the master repository, please be careful not to include your own personalized daemon script or functionality - this is a template and I wish to keep it like that.

## 1. Clone the repository

Get a local clone:
```bash
git clone https://github.com/MortenLoberg/BashDaemonTemplate.git   # clone the repository
```
Copy the template files:
```bash
cp BashDaemonTemplate.git/daemon_template* ~/.                     # copy template files to your home directory, for personalization 
```

## 2. Modify the service script

## 3. Modify the daemon script

## 4. Test-run your script

## 5. Test-run your script as a daemon

Start your daemon script as follows (in some cases you may need to run this command with sudo):
```bash
systemctl start mybashdaemon
```
