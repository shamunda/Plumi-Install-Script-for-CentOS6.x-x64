Plumi-Install-Script-for-CentOS6.x-x64 - BETA
======================================
Experimental Centos Install Experimental

NOTE! Before running the CentOS-Install script make sure you have modified your /etc/hosts file to reflect
the two names being used for the server.

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

Being new to the whole bash scripting thing some things are kludged. Eventually I'll try
my hand at Python and see if we can't make this proper.

There are no provisions for trapping for errors, etc.

However on a clean system, these scripts should get you up and running, other things break,
but not enough to be show stopper. Hopefully with the help fo the community we can clean it up.

Running the scripts
===================

Copy this files to a desired location

chmod +x CentOS*
./CentOS_Plumi-Install.sh

If the installation was successful you should see the status of all the processes actively running.

An update walkthrough for a debian install can be found from Plumi.org at

https://trinket.io/mgogoulos/classes/plumi-4-5#/installation/installation

Enjoy!
