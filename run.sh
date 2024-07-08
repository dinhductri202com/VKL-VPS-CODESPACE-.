######Title Coming soon !
###unset
unset mem
unset core
unset kvdiv
### add some color
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
light_cyan='\033[1;96m'
reset='\033[0m'
##set
usr=`whoami`

case $usr in
   root) clear ;;
   *) echo "Please Run as root!" ; exit ;;
esac


pan()
{
### panner generator on website: https://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20
echo -e $yellow """
██╗   ██╗██╗  ██╗██╗         ██╗   ██╗██████╗ ███████╗
██║   ██║██║ ██╔╝██║         ██║   ██║██╔══██╗██╔════╝
██║   ██║█████╔╝ ██║         ██║   ██║██████╔╝███████╗
╚██╗ ██╔╝██╔═██╗ ██║         ╚██╗ ██╔╝██╔═══╝ ╚════██║
 ╚████╔╝ ██║  ██╗███████╗     ╚████╔╝ ██║     ███████║
  ╚═══╝  ╚═╝  ╚═╝╚══════╝      ╚═══╝  ╚═╝     ╚══════╝  
  ╚═════════════════VKL═VPS══Project════════════════╝"""
}
check()
{
echo -e $yellow "Check"
mem=`free --mega|grep Mem:|awk '{ print $7}'` && printf $yellow"Your MemAvailable: "$reset && echo -e $green"$mem" MB $reset
core=`lscpu|grep "CPU(s):" |awk '{print $2}'` && printf $yellow"Your Cores:"$reset && echo -e $green "$core" $reset
}
checkvm()
{
kvdiv=`ls /dev/kvm`
case "$kvdiv" in
   "/dev/kvm")kvm=ok;lkvm="-enable-kvm -cpu host";;
   *)kvm=no;lkvm="-cpu core2duo";;
esac
###show
case $kvm in
  "ok")echo "KVM Found!" ;;
  "no")echo "KVM Not Found, Run Without KVM !" ;;
esac
unset kvm
unset kvdiv
}

#

setupd()
{
echo -e $blue" > Setup" $reset
echo -e $yellow " ==> Update" $reset
sudo apt update -y >/dev/null 2>&1
echo -e $yellow " ==> Download Package(Ngrok,Qemu,7z)" $reset
wget -qq https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -O ngrok.tgz
tar -xzf ngrok.tgz -C /bin/
sudo apt install p7zip-full p7zip-rar qemu-system -y >/dev/null 2>&1
echo -e $green "Setup Done" $reset
}
ban
printf "$blue paste your NGROK AUTHTOKEN:"reset""
read -p " " ngrok
clear
rm -f os.iso
printf "$blue paste your ISO URL:"$reset""
read -p " " isourl
clear
wget -qq $isourl -O os.iso  –show-progress
check
checkvm
setupd
ngrok authtoken $ngrok
qemu-img create -f qcow2 os.qcow2 90G
nohup ngrok tcp 5901 --region ap &>/dev/null &
sleep 3
clear
pan
echo -e "$blue Connect!"
echo "$yellow ==>  https://github.com/dinhductri202com/VKL-VPS-CODESPACE-. "
qemu-system-x86_64 -device e1000,netdev=n0 -netdev user,id=n0 -machine usb=on -device usb-tablet -vga vmware -cdrom os.iso -hda os.qcow2 -smp cores="$core" -m $mem $lkvm &>/dev/null &
printf ""$green"Your Address: $reset"
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
sleep 10d


