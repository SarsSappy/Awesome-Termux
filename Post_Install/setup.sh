#!/bin/bash
#Script to quickly set-up Termux with all of packages etc after re-installation.
#Written by Sars!
#0.1 Initial release.

#########################################################
################ Vars, Helpers, Imports #################
#########################################################
#Imports.
source ../usr/etc/setup/.config
source ../usr/etc/setup/packages
source ../usr/etc/setup/default_pack
source ../usr/etc/setup/minimal_pack
#Ends.

#Helper Functions.
spk() {
	echo -e "\n$1"
}

#Tput-ify
bl() {
	tput bold
}

ul() {
	tput smul
}

rul() {
	tput rmul
}

rst() {
	tput sgr0
}
#Tput-ify Ends.

clr() {
	tput clear
}
#Ends.

#Functions helpful in Debugging.
err_die() {
	spk "Exiting via code $1" >> setup/.log
	exit "$1"
}

success() {
	spk "$1 Succeeded!" >> setup/.log
}

fail() {
	spk "$1 Failed" >> setup/.log
}
#Ends

#########################################################
###################### Main Stuff #######################
#########################################################
#Check if there is a working internet connection.
chk_con() {
	#Ping google to chechk for internet. Ah yes this command, thanks stackoverflow.
	ping -c 1 google.com &> /dev/null
		if [[ $? = 0 ]]; 
			then
				success "Internet available"
				return 0
		else
			spk "$(bl)No Internet! Please connect to Wi-Fi or enable Mobile Data $(rst)"
			#127.0.0.1, so no internet :P
			err_die "127"
		fi			
}

#First run function to configure stuff.
first_run() {
	while [ $? -eq 0 ]; do
		help
			#Get cur dir name
			#move to the dir where the config & stuff is stored.
			dname="$(pwd)"
			cd $dname
			cp -r usr ../
		sleep 3
	done
}

#Display the help message.
help() {
	clr
	bl
	echo "$(ul)SYNTAX $(rul)"
	echo "       setup {TYPE}... {FLAG}"

			spk "$(ul)TYPES $(rul)"
			rst
			echo "If no TYPE is defined script will first look for user defined packages list or else it will continue with DEFAULT."
			spk "       -D, --default     Installs the packages which comes predefined                          in packages list."
			spk "       -M, --minimal     Installs the basic packages needed to make                            Termux feel more Linux like."
			spk "$(bl) E.g, setup -D or setup -M $(rst)"

	spk "$(bl)$(ul)FLAGS $(rul)$(rst)"
			echo "Flags are optional, as of now only SILENT flag is available."
			spk "       -s, --silent      Makes the script run Silently."
			spk "$(bl) E.g., setup -M -s or setup -M --silent $(rst)"
	spk "That's all the help available.. for now"
} 