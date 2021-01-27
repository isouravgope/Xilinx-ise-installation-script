#!/bin/bash

echo -e "starting the  installation process"
sleep 2s

echo -e "checking libraries"
sleep 2s
librarylib=`find -iname "*libncurses*"`
echo ${blue}"library location is in " $librarylib ${txtrst}

echo "installing required library"
cd ~/.local && wget http://ftp.de.debian.org/debian/pool/main/n/ncurses/libncurses5_6.1+20181013-2+deb10u2_amd64.deb
sudo dpkg -i ~/.local/lib*.deb
echo "removing unwanted packages"
rm -rf ~/.local/lib*.deb
echo "installing library complete"
sleep 5s

echo -e "checking for the Xilinux ISE file"
red=$(tput setaf 1)
blue=$(tput setaf 6)
txtrst=$(tput sgr0)
Xilinx_value=`find /home -iname "*Xilinx_*.tar"`
echo ${blue} "the Xilinx file is stored in $Xilinx_value"${txtrst}
sleep 2s
echo "press '1' for auto install '2' for exiting the process "
while :
do
  read INPUT_STRING
  case $INPUT_STRING in
	1)
		echo "Auto starting the installation!"
		cd ~/ && rm -rf Xilinx*
		cp -r $Xilinx_value ~/
		echo "done copying"
		sleep 2s
		tar -xvf Xilinx_ISE_DS*.tar
		sleep 2s
		rm -rf ~/Xilinx*.tar
		echo "extraction complete"
		cd ~/Xilinx_ISE_DS*
		sudo bash ~/Xilinx_ISE_DS*/xsetup
		echo "installation complete"
		sleep 2s
		echo "copying the destop entry"
		cd ~/.local/share/applications && curl https://raw.githubusercontent.com/TheGlitchh/Xilinix_ise_installation_script/main/xilinxISE.desktop > xilinxISESuit.desktop
		echo ${red}"if you have changed the default installation directory then you need to modify the desktop entry file accordingly"${txtrst}
		sleep 5s
		echo "the destop entry file is in ~/.local/share/applications"
		sleep 4s
		cd ~/.local/ && curl https://raw.githubusercontent.com/TheGlitchh/Xilinix_ise_installation_script/main/run_ise.sh > run_ise.sh
		sleep 1s
		sudo mv ~/.local/run_ise.sh /opt/Xilinx/14.7/ISE_DS/run_ise.sh
		sleep 2s
		Xilinx_png=`find /opt -iname "*pn-ise.png*"`
		sleep 1s
		rm -rf ~/.local/pn-ise.png
		cp -r $Xilinx_png ~/.local
		echo "installation is done"
		echo "removing unused files"
		rm -rf ~/Xilix*
		echo "reboot your system if application is not showing"
		exit
		;;
	2)
		echo "aborting the installation process!"
		exit
		break
		;;
	*)
		echo "Unknown command"
		;;
  esac
done
