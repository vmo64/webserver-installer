# WebServer Essentials Installer
This script saves you alot of time by preconfiguring the whole webserver stack
***This script does not work properly on debian***

## How to use the script?
1. Make sure you are root! (by doing ``sudo su``)
2. Download and run installer: `wget https://raw.githubusercontent.com/vmo64/lampserver-installer/main/install.sh` then `sudo bash install.sh`
3. WebServer is installed on your machine!

## OS compatibility
| Operating System | Version | Supported? |
| --------------- | --------------- | --------------- |
| Ubuntu | 20.04 | ✅ |
|        | 18.04 | ✅ |
| Debian | 11 | ❌ |
|        | 10 | ❌ |
|        | 9 | ❌ |
| CentOS | 8 | ❌ |
|        | 7 | ❌ |

## Requirements
- Ubuntu 18.04 or above
- 64 Bit OS
- Internet connection

### History:
*2.0 Release*
- Renamed repository from `lampserver-installer` to `webserver-installer`
- Added a menu with more options
- Added NGINX stack support
- Added individual options
- Integrated SSL script into the main menu 

*1.1 Release*
- Fully automated setup
- SSL addon added

*1.0 Pre Release*
- Semi automated LAMP install script

Enjoy.
