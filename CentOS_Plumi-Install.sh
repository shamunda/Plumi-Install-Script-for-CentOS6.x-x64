#!/bin/bash
# Quick and Direct Plumi install script for CentOS 6.x x64 Only!
# Plumi install script create by Dennis Ross (http://www.ssctech.com)
# Sept 2014
# Issued under GNU GPL
# v0.1


# Begin Plumi Install
clear
RED='\033[01;31m'
GREEN='\e[0;32m'
YELLOW='\e[1;33m'
RESET='\033[0m'


export who=`whoami`
SCRIPTDIRECTORY="$(pwd)"
clear
createDirectory()
{
 read -p "Install path? Leave off trailing '/' (Default: /opt/plumi.app): " installpath
        if [ "$install" = "" ]; then
        	echo -e $RED"Using default..."$RESET
        	installpath="/opt"
        elif [ ! -d "$installpath" ]; then
           echo -e $RED"Creatind direcorty..."$RESET
           mkdir -pv $installpath
        else
           echo -e $GREEN"$installpath already exist...continuing"$RESET
        fi
}
c=0
while [ $c -le 0 ]
do
   if [[ $who == "root" ]]; then
      createDirectory
      cd $installpath
      git clone https://github.com/plumi/plumi.app/
      echo -e $YELLOW"Successfull download...continuing"$RESET
      sleep 3

      #create plumi user 'zope'
      useradd -G users,wheel,nobody -s /bin/bash zope

      # $SCRIPTDIRECTORY/CentOS_Plumi-Prep.sh | tee /var/log/centos_plumi_install.$lpid.log
      $SCRIPTDIRECTORY/CentOS_Plumi-Prep.sh
      $SCRIPTDIRECTORY/CentOS_Plumi-Build.sh
   else
      echo -e $RED"You must be root to run this script."$RESET
   fi
   (( c++ ))
done