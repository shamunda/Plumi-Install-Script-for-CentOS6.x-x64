Plumi-Install-Script-for-CentOS6.x-x64 - BETA
======================================
This is still all experimental

NOTE! Before running the CentOS-Install script make sure you have modified your /etc/hosts file to reflect
the two external names being used for the server.

Example:
portal.myserver.com
video.myserver.com

Failure to modify your /etc/hosts file before running the install script will require you to rerun ./bin/buildout again.
Make it easy on yourself, you've been warned ;)

Let's get started!

Shell scripts to aid with the installation of the Plumi video server on "clean" CentOS v6.x 64bit systems only.

There are 3 shell scripts:
CentOS_Plumi-Install.sh
CentOS_Plumi-Prep.sh
CentOS_Plumi-Build.sh

It's highly recommended you run these scripts on a "clean minimal install" of CentOS 6.x. These are simple bash scripts which provide very little event trapping for errors (simply because this is the first time I'm writing bash scripts :P).

However on a clean system, these scripts should get you up and running.

Getting Started
===============

Copy this files to a desired location

chmod +x CentOS*
./CentOS_Plumi-Install.sh

Follow the prompts
