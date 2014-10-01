Plumi-Install-Script-for-CentOS6.x-x64 - BETA
======================================
This is still experimental

NOTE! Before running the CentOS-Install script make sure you have modified your /etc/hosts file to reflect
the two external names being used for the server.

Example:
portal.myserver.com
video.myserver.com

Failure to modify your /etc/hosts file before running the install script will require you to rerun ./bin/buildout again.

Make it easy on yourself, you've been warned ;)

Let's get started!
=================
yum install git -y

Clone: git clone https://github.com/shamunda/Plumi-Install-Script-for-CentOS6.x-x64.git

These script will aid in the installation of the Plumi video server on "clean" CentOS v6.x 64bit systems only.

There are three files:
CentOS_Plumi-Install.sh
CentOS_Plumi-Prep.sh
CentOS_Plumi-Build.sh

I REPEAT: It's highly recommended you run these scripts on a "clean minimal install" 
of CentOS 6.x. 

Being new to the whole bash scripting thing so things are kludged. Eventually I'll try
my hand at Python and see if we can't make this proper.
There are no provisions for trapping for errors, etc.

However on a clean system, these scripts should get you up and running, other things break but
hopefully with everyones help we can clear it up.

Running the scripts
===================

Copy this files to a desired location

chmod +x CentOS*
./CentOS_Plumi-Install.sh

Follow the prompts.
