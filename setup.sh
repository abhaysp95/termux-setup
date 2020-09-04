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

logfile="${HOME}/.setup_log"

echo "Would you want to provide your termux a password" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
echo -e $G"y$W or$R n$W"
read -rn1 pass
echo

function set_pass() {
	if [ "$pass" = "y" ]; then
		echo "yes" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
	else
		echo "no" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
	fi
}

set_pass

function update_upgrade() {
	apt update 2> /dev/null && apt -y upgrade 2> /dev/null \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
}

echo
echo -e $G"Updating Termux$W" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
echo

count=0
function check_update() {
	update_errcd=1
	if ! update_upgrade; then
		update_errcd="$?"
		echo "error ${update_errcd}" \
		| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
		| tee -a "${logfile}" 1> /dev/null
		count=$(( count + 1 ))
		echo -e $R"Updation failed$W, check if internet connection is active" \
		| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
		| tee -a "${logfile}" 1> /dev/null
		echo "It's recommended to update if it's the first time" \
		| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
		| tee -a "${logfile}" 1> /dev/null
	fi
}

check_update

function check_update2() {
	if [ "${update_errcd}" -eq 1 ]; then
		echo -e $G"Update Succesful" \
		| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
		| tee -a "${logfile}" 1> /dev/null
	else
		echo "Try again or Skip" \
		| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
		| tee -a "${logfile}" 1> /dev/null
		echo -e $G"y$W or$R s$W" \
		| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
		| tee -a "${logfile}" 1> /dev/null
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
			echo "You choose to skip" \
			| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
			| tee -a "${logfile}" 1> /dev/null
			break
		fi
		#echo "inside while"
		#echo "${update_again}"
	done
	if [ "${count}" -ge 3 ]; then
		echo -e $R"Skipping$W for Now, or do you want to quit" \
		| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
		| tee -a "${logfile}" 1> /dev/null
		echo -e $G"s$W or$R q$W"
		read -rn1 if_skip
		if [ "${if_skip}" = q ]; then
			echo -e $Y"Exiting Now, BYE$W" \
			| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
			| tee -a "${logfile}" 1> /dev/null
			exit
		else
			echo "Tried, more than 3 times. NOW, " \
			| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
			| tee -a "${logfile}" 1> /dev/null
			echo -e $G"SKIPPING$W" \
			| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
			| tee -a "${logfile}" 1> /dev/null
		fi
	fi
fi

echo
echo -e $Y"Setting up storage settings" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
echo -e $G"Grant the permission" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null

if [ -d ~/storage ]; then
  echo
  echo -e $G"Storage is already setup, proceeding further" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
else
  echo
  termux-setup-storage
	echo -e $Y"Storage setup successful" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
	echo -e $W"Created a folder named storage" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
fi

if [ "${update_errcd}" -ne 0 ]; then
	echo
	echo -e $G"Installing some basic softwares$W" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
	ins_pro=0
else
	ins_pro=1
	echo
	echo -e $R"Program installations has been skipped" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
fi

function install_programs() {
	echo
	echo -e $Y"Installing man" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
	apt install -y man \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null

	echo
	echo -e $Y"Installing text editors$W" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
	apt install -y neovim nano \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null

	echo
	echo -e $Y"Installing language & tools$W" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
	apt install -y coreutils python make libllvm llvm libcrypt-dev \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null

	echo
	echo -e $Y"Installing tools to retrieve and transfer data$W" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
	apt install -y curl wget aria2

	echo
	echo -e $Y"Installing a nice file manager$W" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
	apt install -y lf \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null

	echo
	echo -e $Y"Installing termux specific tools$W" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
	apt install -y termux-exec proot tsu \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null

	echo
	echo -e $Y"Installing network and sharing tools$W" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
	apt install -y openssh nmap dnsutils \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
}

if [ "${ins_pro}" -eq 0 ]; then
	install_programs
fi

echo $B"  ** Installing termux-setup **  "$W
[ ! -d "$HOME"/.termux ] && mkdir "$HOME"/.termux \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null

cp "$CDIR"/materials.tar.gz "$PREFIX"/share \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
echo -e $Y"  =>  Extracting data..."$W \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
tar xvzf "$PREFIX"/share/materials.tar.gz -C "$PREFIX"/share \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
chmod 755 "$PREFIX"/share/termux-setup/tsetup \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
ln -sv "$PREFIX"/share/termux-setup/tsetup "$PREFIX"/bin/termux-setup \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
rm -v "$PREFIX"/share/materials.tar.gz \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null

echo
echo -e $C"Initial Setup Complete" \
	| sed -e "s/^/$(printf "%s\t" "$(date "+%Y:%m:%d %H:%M:%s")")/" \
	| tee -a "${logfile}" 1> /dev/null
echo -e $G"For further setup, type$Y 'termux-setup'$W"
echo -e $Y"Exiting Now$W"
echo
