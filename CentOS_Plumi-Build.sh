#!/bin/bash
#
# Quick and Direct Plumi install script for CentOS 6.x x64 Only!
# Plumi install script create by Dennis Ross (http://www.playlan.com)
# Sept 2014
# Issued under GNU GPL
# v0.1

# Modify, build, and run Plumi for CenOS 6.x 64bit ONLY!
clear
RED='\033[01;31m'
GREEN='\e[0;32m'
YELLOW='\e[1;33m'
RESET='\033[0m'
#_bootstrap='http://downloads.buildout.org/2/bootstrap.py'
_bootstrap='https://raw.github.com/buildout/buildout/1/bootstrap/bootstrap.py'
# First find the plumi.app install path
findinstallpath()
{
   find / -name plumi.app -prune
}
_installpath=$( findinstallpath )
clear
echo -e $YELLOW"Making a few specific OS mods before running plumi python scripts..."$RESET
sleep 3

#create plumi user 'zope'
useradd -G users,wheel,nobody -s /bin/bash zope

# Create virtual Encironment
cd $_installpath
virtualenv-2.7 .
source $_installpath/bin/activate

# Download bootstrap source
mv bootstrap.py bootstrap.py.old && wget $_bootstrap
# Modifying buildout.cfg (needed for using bootstrap.py v2)
# perl -i -p -e "s/buildout.dumppickedversions//g" $_installpath/buildout.cfg
cd $_installpath/ffmpeg
mv bootstrap.py bootstrap.py.old && wget $_bootstrap

# Override default python egg cache directory
cd $_installpath
mkdir -p $_installpath/tmp/python_eggs
export PYTHON_EGG_CACHE=$_installpath/tmp/python_eggs
echo $PYTHON_EGG_CACHE
echo "PYTHON_EGG_CACHE=$_installpath/tmp/python_eggs" >> /etc/environment
chmod 777 -R $_installpath/tmp

# Modify site.cfg
cp $_installpath/site.cfg $_installpath/site.cfg.original
perl -i -p -e "s/www-data/root/g" $_installpath/site.cfg
read -p "Enter administators name (ex: admin): " adminname
perl -i -p -e "s/admin:/$adminname:/g" $_installpath/site.cfg
read -p "Enter administrator password: " adminpass
perl -i -p -e "s/:admin/:$adminpass/g" $_installpath/site.cfg
read -p "Enter Portal server name (ex: new.plumi.org): " portalservername
perl -i -p -e "s/new.plumi.org/$portalservername/g" $_installpath/site.cfg
read -p "Enter Video Server name (ex: newvideos.plumi.org): " videoservername
perl -i -p -e "s/newvideos.plumi.org/$videoservername/g" $_installpath/site.cfg

## Pinnning Specific python version for apps and libraries (experimental)
#if ! grep -Fxq "zdaemon = 4.0.0a1" "$_installpath/buildout.cfg"; then
#    line=$(cat "$_installpath/buildout.cfg" | grep -n "collective.transcode.star" | grep -o '^[0-9]*')
#    line=$((line))
#    sed -i ${line}"i\zdaemon = 4.0.0a1" "$_installpath/buildout.cfg"
#    else
#       echo -e $GREEN"zdaemon 4.0.0a1 - already Installed :)"$RESET
#fi
#if ! grep -Fxq "collective.js.jqueryui = 1.8.16.9" "$_installpath/buildout.cfg"; then
#    line=$(cat "$_installpath/buildout.cfg" | grep -n "collective.transcode.star" | grep -o '^[0-9]*')
#    line=$((line))
#    sed -i ${line}"i\collective.js.jqueryui = 1.8.16.9" "$_installpath/buildout.cfg"
#    else
#       echo -e $GREEN"'collective.js.jqueryui 1.8.16.9 - already Installed :)"$RESET
#fi

# Taken directly from the install instructions
# Run the buildout
cd $_installpath
./bin/python bootstrap.py && ./bin/buildout -v
cd $_installpath/ffmpeg
../bin/python bootstrap.py && ./bin/buildout -v
cd $_installpath
./bin/supervisord
clear
echo -e $YELLOW"Displaying Running Status"$RESET
./bin/supervisorctl status
sleep 3
