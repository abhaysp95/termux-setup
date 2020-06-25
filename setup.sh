#!/bin/bash

R='\033[1;31m'
B='\033[1;34m'
C='\033[1;36m'
G='\033[1;32m'
W='\033[1;37m'
Y='\033[1;33m'

CDIR="$(pwd)"

echo
echo -e $G"   ┌────────────────────────────────────┐"
echo -e $G"   │$R╺┳╸┏━╸┏━┓┏┳┓╻ ╻╻ ╻   $B┏━┓┏━╸╺┳╸╻ ╻┏━┓$G│"
echo -e $G"   │$R ┃ ┣╸ ┣┳┛┃┃┃┃ ┃┏╋┛$Y╺━━$B┗━┓┣╸  ┃ ┃ ┃┣╸┛$G│"
echo -e $G"   │$R ╹ ┗━╸╹┗╸╹ ╹┗━┛╹ ╹   $B┗━┛┗━╸ ╹ ┗━┛╹  $G│"
echo -e $G"   └────────────────────────────────────┘"
echo -e $G"     [$R*$G]--> By$Y ABHAY$C SHANKER$B PATHAK"
echo
# ┳┛

echo -e "$B  Setting the script"

echo "Would you want to provide your termux a password"
echo -e $G"y$W or$R n$W"
read -rn1 pass
echo

function set_pass() {
	if [ "$pass" = "y" ]; then
		echo "yes"
	else
		echo "no"
	fi
}

set_pass

function update_upgrade() {
	apt update 2> /dev/null
	apt upgrade 2> /dev/null
}

echo
echo -e $G"Updating Termux$W"
echo

count=0
function check_update() {
	update_errcd=1
	if ! update_upgrade; then
		update_errcd="$?"
		count=$(( count + 1 ))
		echo -e $R"Updation failed$W, check if internet connection is active"
		echo "It's recommended to update if it's the first time"
	fi
}

check_update

function check_update2() {
	if [ "${update_errcd}" -eq 1 ]; then
		echo -e $G"Update Succesful"
	else
		echo "Try again or Skip"
		echo -e $G"y$W or$R n$W"
		read -rn1 update_again
	fi
}
check_update2

if [ "${update_again}" != "" ]; then
	while [[ "${update_errcd}" -ne 1 || "${count}" -le 3 ]]; do
		if [ "${udpate_again}" = "y" ]; then
			check_update
			check_update2
		fi
	done
	if [ "${count}" -eq 3 ]; then
		echo -e $R"Skipping$W for Now, or do you want to quit"
		echo -e $G"s$W or$R q$W"
		read -rn1 if_skip
		if [ "${if_skip}" = q ]; then
			exit
		else
			echo $G"SKIPPING$G"
		fi
	fi
fi

echo
echo "DONE"
echo
