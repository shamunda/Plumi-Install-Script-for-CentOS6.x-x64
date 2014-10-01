#!/bin/bash
# Quick and Direct Plumi install script for CentOS 6.x x64 Only!
# Plumi install script create by Dennis Ross (http://www.ssctech.com)
# Sept 2014
# Issued under GNU GPL
# v0.1


# System Preperation script (CENTOS 6.x 64bit ONLY!)

# Disable firewall
clear
RED='\033[01;31m'
GREEN='\e[0;32m'
YELLOW='\e[1;33m'
RESET='\033[0m'

source_dir='/usr/src'
python_source_url='http://www.python.org/ftp/python'
python_source_ver='2.7.3'
_python27_xz_file='Python-2.7.3.tar.xz'
_python27_package='Python-2.7.3.tar'
SCRIPTDIRECTORY="$(pwd)"

echo -e $RED"Prepping environment ...."$RESET
export PATH="/usr/local/bin:$PATH"
sleep 3

grep /usr/local/lib /etc/ld.so.conf || echo "/usr/local/lib" >> /etc/ld.so.conf
ldconfig

service iptables save && \
service iptables stop && \
chkconfig iptables off && \
service ip6tables save && \
service ip6tables stop && \
chkconfig ip6tables off

# Disabled SELINUX
cd /etc/selinux && sed -i -e "s/SELINUX=enforcing/SELINUX=disabled/g" config
sed -i 's/ quiet/ selinux=0 quiet/g' /etc/grub.conf
setenforce 0

# Update CentOS
yum update -y

# Enable Time services and update
yum install ntp ntpdate -y
ntpdate pool.ntp.org

# Add preq-repos
rpm -Uvh http://mirror.pnl.gov/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uhv http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm

# Adding prerequisites
# First Dev Tools
yum groupinstall "Development Tools" -y

# Then applications and support libraries
yum install openssl-devel sqlite-devel bzip2-devel libxslt-devel pcre groff ruby-devel libxml2 libxml2-devel libxslt libxslt-devel git-all zlib zlib-devel zlibrary zlib-devel libjpeg-turbo libjpeg-turbo-devel groff groff-perl bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel python-virtualenv tkinter freetype freetype-devel python-lcms lcms-devel python-webpy python-devel x264-devel libvpx-devel python-imaging wget ftp nano vim xz-libs -y

# Python27 Prep
cd $source_dir
echo -e $YELLOW"Installing Python2.7 ..."$RESET
echo
echo "Grabbing sources ...."
	if [ -e $source_dir/$_python27_package ];then
     echo " "
	   echo -e $GREEN$_python27_package" already downloaded."$RESET
	   echo " "
	   else
		    echo " "
		    echo -e $RED"Installing ..."$RESET; wget $python_source_url/$python_source_ver/$_python27_xz_file &> /dev/null
        xz -d $_python27_xz_file
        tar xf $_python27_package
        cd $source_dir/Python-$python_source_ver
        #./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" &> /dev/null
        ./configure
        make && make altinstall
	      echo " "
        echo -e $RED"Adding PIP ..."$RESET
		    cd $source_dir
        # wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-5.8.tar.gz &> /dev/null
        wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
		    # tar -xvf setuptools-5.8.tar.gz
		    python2.7 ez_setup.py
		    # cd $source_dir/setuptools-5.8
		    easy_install-2.7 pip
		    pip2.7 install virtualenv
		    # python2.7 setup.py install
		    #curl https://raw.githubusercontent.com/pypa/pip/master/contrib/get-pip.py | python2.7 -
		    #pip install virtualenv
	fi

# Install WEBP
cd $source_dir
echo " "
echo -e $YELLOW"WEBP ..."$RESET
echo
echo -e $YELLOW"Grabbing sources ...."$RESET
        if [ -e $source_dir/libwebp-0.4.1.tar.gz ];then
           echo " "
           echo -e $GREEN""libwebp-0.4.1.tar.gz"Already downloaded!"$RESET
           echo " "
           else
              echo " "
              echo -e $RED"Installing ..."$RESET; wget http://downloads.webmproject.org/releases/webp/libwebp-0.4.1.tar.gz &> /dev/null
              tar xzf libwebp-0.4.1.tar.gz
              cd libwebp-0.4.1
              ./configure
              make && make install
              ldconfig
       fi
      
# CentOS Prep done

echo -e $YELLOW"CentOS Successfully Prepared."$RESET
echo -e $YELLOW"Continuing..."$RESET
echo -e $GREEN"Switching to script directory"$RESET
echo $SCRIPTDIRECTORY && cd $SCRIPTDIRECTORY
sleep 3