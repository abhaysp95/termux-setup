#!/data/data/com.termux/files/usr/bin/bash

# TODO:
# method of taking log is problematic, it's outputing to terminall also

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>~/log.out 2>&1

R='\033[1;31m'
B='\033[1;34m'
C='\033[1;36m'
G='\033[1;32m'
W='\033[1;37m'
Y='\033[1;33m'

CDIR="$(pwd)"

echo >&3
echo -e $G"   ┌────────────────────────────────────┐" >&3
echo -e $G"   │$R╺┳╸┏━╸┏━┓┏┳┓╻ ╻╻ ╻   $B┏━┓┏━╸╺┳╸╻ ╻┏━┓$G│" >&3
echo -e $G"   │$R ┃ ┣╸ ┣┳┛┃┃┃┃ ┃┏╋┛$Y╺━━$B┗━┓┣╸  ┃ ┃ ┃┣╸┛$G│" >&3
echo -e $G"   │$R ╹ ┗━╸╹┗╸╹ ╹┗━┛╹ ╹   $B┗━┛┗━╸ ╹ ┗━┛╹  $G│" >&3
echo -e $G"   └────────────────────────────────────┘" >&3
echo -e $G"     [$R*$G]--> By$Y ABHAY$C SHANKER$Y PATHAK" >&3
echo >&3
# ┳┛
date "+%Y:%m:%d %H:%M:%s"

date "+Y:%m:%d %H:%M:%s"
echo -e "$B  Setting the script" >&3

date "+Y:%m:%d %H:%M:%s"
echo "Would you want to provide your termux a password" >&3
echo -e $G"y$W or$R n$W" >&3
read -rn1 pass
echo >&3

function set_pass() {
	if [ "$pass" = "y" ]; then
		date "+%Y:%m:%d %H:%M:%s"
		passwd >&3
	else
		date "+%Y:%m:%d %H:%M:%s"
		echo "You can also set password later" >&3
	fi
}

set_pass

function update_upgrade() {
	date "+%Y:%m:%d %H:%M:%s"
	apt-get update 2> /dev/null && apt-get -y upgrade 2> /dev/null >&3
}

echo >&3
date "+%Y:%m:%d %H:%M:%s"
echo -e $G"Updating Termux$W" >&3
echo >&3

count=0
function check_update() {
	update_errcd=1
	if ! update_upgrade; then
		update_errcd="$?"
		date "+%Y:%m:%d %H:%M:%s"
		echo "error ${update_errcd}" >&3
		count=$(( count + 1 ))
		date "+%Y:%m:%d %H:%M:%s"
		echo -e $R"Updation failed$W, check if internet connection is active" >&3
		echo "It's recommended to update if it's the first time" >&3
	fi
}

check_update

function check_update2() {
	if [ "${update_errcd}" -eq 1 ]; then
		date "+%Y:%m:%d %H:%M:%s"
		echo -e $G"Update Succesful" >&3
	else
		date "+%Y:%m:%d %H:%M:%s"
		echo "Try again or Skip" >&3
		echo -e $G"y$W or$R s$W" >&3
		date "+%Y:%m:%d %H:%M:%s"
		read -rn1 update_again >&3
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
			date "+%Y:%m:%d %H:%M:%s"
			echo "You choose to skip" >&3
			break
		fi
		#echo "inside while"
		#echo "${update_again}"
	done
	if [ "${count}" -ge 3 ]; then
		date "+%Y:%m:%d %H:%M:%s"
		echo -e $R"Skipping$W for Now, or do you want to quit" >&3
		echo -e $G"s$W or$R q$W" >&3
		read -rn1 if_skip >&3
		if [ "${if_skip}" = q ]; then
			date "+%Y:%m:%d %H:%M:%s"
			echo -e $Y"Exiting Now, BYE$W" >&3
			exit
		else
			date "+%Y:%m:%d %H:%M:%s"
			echo "Tried, more than 3 times. NOW, " >&3
			date "+%Y:%m:%d %H:%M:%s"
			echo -e $G"SKIPPING$W" >&3
		fi
	fi
fi

echo >&3
date "+%Y:%m:%d %H:%M:%s"
echo -e $Y"Setting up storage settings" >&3
date "+%Y:%m:%d %H:%M:%s"
echo -e $G"Grant the permission" >&3

if [ -d ~/storage ]; then
  echo >&3
	date "+%Y:%m:%d %H:%M:%s"
  echo -e $G"Storage is already setup, proceeding further" >&3
else
	echo >&3
	date "+%Y:%m:%d %H:%M:%s"
	termux-setup-storage
	echo -e $Y"Storage setup successful" >&3
	date "+%Y:%m:%d %H:%M:%s"
	echo -e $W"Created a folder named storage" >&3
fi

if [ "${update_errcd}" -ne 0 ]; then
	echo >&3
	date "+%Y:%m:%d %H:%M:%s"
	echo -e $G"Installing some basic softwares$W" >&3
	ins_pro=0
else
	ins_pro=1
	echo >&3
	date "+%Y:%m:%d %H:%M:%s"
	echo -e $R"Program installations has been skipped" >&3
fi

function install_programs() {
	echo >&3
	date "+%Y:%m:%d %H:%M:%s"
	echo -e $Y"Installing man"$W >&3
	apt-get install -y man >&3

	echo >&3
	date "+%Y:%m:%d %H:%M:%s"
	echo -e $Y"Installing text editors$W" >&3
	apt-get install -y neovim nano >&3

	echo >&3
	date "+%Y:%m:%d %H:%M:%s"
	echo -e $Y"Installing language & tools$W" >&3
	date "+%Y:%m:%d %H:%M:%s"
	apt-get install -y coreutils python make libllvm llvm libcrypt >&3

	echo >&3
	date "+%Y:%m:%d %H:%M:%s"
	echo -e $Y"Installing tools to retrieve and transfer data$W" >&3
	apt-get install -y curl wget aria2 >&3

	echo >&3
	date "+%Y:%m:%d %H:%M:%s"
	echo -e $Y"Installing a nice file manager$W" >&3
	date "+%Y:%m:%d %H:%M:%s"
	apt-get install -y nnn >&3

	echo >&3
	date "+%Y:%m:%d %H:%M:%s"
	echo -e $Y"Installing termux specific tools$W" >&3
	date "+%Y:%m:%d %H:%M:%s"
	apt-get install -y termux-exec proot tsu >&3

	echo >&3
	date "+%Y:%m:%d %H:%M:%s"
	echo -e $Y"Installing network and sharing tools$W" >&3
	date "+%Y:%m:%d %H:%M:%s"
	apt-get install -y openssh nmap dnsutils >&3
}

if [ "${ins_pro}" -eq 0 ]; then
	install_programs
fi

echo $B"  ** Installing termux-setup **  "$W >&3
date "+%Y:%m:%d %H:%M:%s"
[ ! -d "$HOME"/.termux ] && mkdir "$HOME"/.termux >&3

date "+%Y:%m:%d %H:%M:%s"
cp "$CDIR"/materials.tar.gz "$PREFIX"/share >&3
date "+%Y:%m:%d %H:%M:%s"
echo -e $Y"  =>  Extracting data..."$W >&3
date "+%Y:%m:%d %H:%M:%s"
tar xvzf "$PREFIX"/share/materials.tar.gz -C "$PREFIX"/share >&3
date "+%Y:%m:%d %H:%M:%s"
chmod 755 "$PREFIX"/share/termux-setup/tsetup >&3
date "+%Y:%m:%d %H:%M:%s"
ln -sv "$PREFIX"/share/termux-setup/tsetup "$PREFIX"/bin/termux-setup >&3
date "+%Y:%m:%d %H:%M:%s"
rm -v "$PREFIX"/share/materials.tar.gz >&3

echo >&3
date "+%Y:%m:%d %H:%M:%s"
echo -e $C"Initial Setup Complete" >&3
echo -e $G"For further setup, type$Y 'termux-setup'$W" >&3
echo -e $Y"Exiting Now$W" >&3
echo >&3
