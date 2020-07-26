#!/data/data/com.termux/files/usr/bin/bash

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
echo -e $G"     [$R*$G]--> By$Y ABHAY$C SHANKER$Y PATHAK"
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
	apt update 2> /dev/null && apt -y upgrade 2> /dev/null
}

echo
echo -e $G"Updating Termux$W"
echo

count=0
function check_update() {
	update_errcd=1
	if ! update_upgrade; then
		update_errcd="$?"
		echo "error ${update_errcd}"
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
		echo -e $G"y$W or$R s$W"
		read -rn1 update_again
	fi
}
check_update2
echo "${update_again}"

if [ -n "${update_again}" ]; then
	#echo "inside if"
	#echo "${update_again}"
	while [[ "${update_errcd}" -ne 1 && "${count}" -le 3 ]]; do
		if [ "${update_again}" = "y" ]; then
			#echo "inside while if"
			check_update
			check_update2
			#echo "${count}"
		else
			echo "You choose to skip"
			break
		fi
		#echo "inside while"
		#echo "${update_again}"
	done
	if [ "${count}" -ge 3 ]; then
		echo -e $R"Skipping$W for Now, or do you want to quit"
		echo -e $G"s$W or$R q$W"
		read -rn1 if_skip
		if [ "${if_skip}" = q ]; then
			echo -e $Y"Exiting Now, BYE$W"
			exit
		else
			echo "Tried, more than 3 times. NOW, "
			echo -e $G"SKIPPING$W"
		fi
	fi
fi

echo
echo -e $Y"Setting up storage settings"
echo -e $G"Grant the permission"

if [ -d ~/storage ]; then
  echo
  echo -e $G"Storage is already setup, proceeding further"
else
  echo
  termux-storage-setup
	echo -e $Y"Storage setup successful"
	echo -e $W"Created a folder named storage"
fi

if [ "${update_errcd}" -ne 0 ]; then
	echo
	echo -e $G"Installing some basic softwares$W"
	ins_pro=0
else
	ins_pro=1
	echo
	echo -e $R"Program installations has been skipped"
fi

function install_programs() {
	echo
	echo -e $Y"Installing man"
	apt install -y man

	echo
	echo -e $Y"Installing text editors$W"
	apt install -y neovim nano

	echo
	echo -e $Y"Installing language & tools$W"
	apt install -y coreutils python3 make libllvm llvm libcrypt-dev

	echo
	echo -e $Y"Installing tools to retrieve and transfer data$W"
	apt install -y curl wget aria2

	echo
	echo -e $Y"Installing a nice file manager$W"
	apt install -y lf

	echo
	echo -e $Y"Installing termux specific tools$W"
	apt install -y termux-exec proot tsu

	echo
	echo -e $Y"Installing network and sharing tools$W"
	apt install -y openssh nmap dnsutils
}

if [ "${ins_pro}" -eq 0 ]; then
	install_programs
fi

echo $B"  ** Installing termux-setup **  "$W
[ ! -d "$HOME"/.termux ] && mkdir "$HOME"/.termux

cp "$CDIR"/materials.tar.gz "$PREFIX"/share
echo -e $Y"  =>  Extracting data..."$W
tar xvzf "$PREFIX"/share/materials.tar.gz -C "$PREFIX"/share
chmod 755 "$PREFIX"/share/termux-setup/tsetup
ln -s "$PREFIX"/share/termux-setup/tsetup "$PREFIX"/bin/termux-setup
rm "$PREFIX"/share/materials.tar.gz

echo
echo -e $C"Initial Setup Complete"
echo -e $G"For further setup, type$Y 'termux-setup'$W"
echo -e $Y"Exiting Now$W"
echo
