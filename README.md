# WebServer Essentials Installer

<a href="#">
    <img src="https://img.shields.io/badge/version-latest-brightgreen.svg" /></a>
<a href="https://github.com/vmo64/webserver-installer/releases/tag/2.0">
    <img src="https://img.shields.io/badge/latest%20release-2.0-blue.svg" /></a>
   
This script saves you alot of time by preconfiguring the whole webserver stack

## How to use the script?
1. Make sure you are root! (by doing ``sudo su``)
2. Download and run installer: `wget https://raw.githubusercontent.com/vmo64/lampserver-installer/main/install.sh` then `bash install.sh`
3. Select the option you want from the list (entering an invalid option makes the script exit)
4. Enter the information required
3. The option you have selected is installed

## OS compatibility
| Operating System | Version | Supported? |
| --------------- | --------------- | --------------- |
| Ubuntu | 22.04 LTS | ✅ |
|        | 20.04 LTS | ✅ |
|        | 18.04 LTS | ✅ |
| Debian | 11 | ❓ |
|        | 10 | ❓ |
|        | 9  | ❓ |
|        | 9 | ❌ |
| CentOS | 8 | ❌ |
|        | 7 | ❌ |

*Note: This script does work on Debian systems but some phpMyAdmin problems may happen.*

## Features and options
| Option | Option No. | Support Status |
| --------------- | --------------- | --------------- |
| LAMP | 1 | ✅ |
| LEMP | 2 | ❓ |
| Apache | 3 | ✅ |
| NGINX | 4 | ✅ |
| MySQL | 5 | ✅ |
| phpMyAdmin | 6 | ✅ |
| SSL Script | 7 | ✅ |

## Requirements
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
