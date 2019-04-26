#!/bin/bash
clear
if [ "$(whoami)" != "root" ]; then
	echo "Please run this script as sudo."
	exit 1
fi

apt-get install whiptail -y

if (whiptail --title "Update & Upgrade" --yesno "Do you want to update your system?" 10 60) then
    	sudo apt-get update && apt-get upgrade
	sudo apt-get install git xz-utils wget curl -y 
else
	if [[ $1 == "--no-update" ]]; then
		echo "ok mr expert. but its your fault if something breaks."
		sudo apt-get install git xz-utils -y
	else
		echo "Sorry, we cant support you then."
		exit 1
	fi
	
fi


installlocation=$(whiptail --title "Question" --inputbox "Choose a location for everything to install." 10 60 /home/fx/ 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    if [ -d $installlocation ]; then
    	echo "That directory exist already. Please choose a non existent."
    	exit 1;
    fi
else
    echo "Aborting."
    exit 1
fi



## install process

    mkdir -p $installlocation/fxdata
	cd $installlocation/fxdata
	masterfolder="https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/"
	masterfolder="https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/1"
	newestfxdata="$(curl $masterfolder | grep '<a href' | grep -v 'revoked' | head -2 | tail -1 | grep -Po '(?<=href="1)[^"]*')"
	wget ${masterfolder1}${newestfxdata}fx.tar.xz 
	tar xf fx.tar.xz
	rm fx.tar.xz
	cd ..
	mkdir servers
	mkdir managerfiles
	wget https://raw.githubusercontent.com/jbrown1060/fivem-servermanager/master/manager.sh
	cd ./managerfiles
	wget https://raw.githubusercontent.com/jbrown1060/fivem-servermanager/master/managerfiles/default-config.cfg
	wget https://raw.githubusercontent.com/jbrown1060/fivem-servermanager/master/managerfiles/used-ports.txt
	cd ..
	chmod -R 777 $installlocation
	
clear
echo "Installation process is over."
echo "To start the manager, use 'sudo ${installlocation}/manager.sh'."
echo "Please update the FXdata."
