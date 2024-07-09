######FDStart
#pkill
pkill qenu
pkill ngrok
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
pan
clear
check
checkvm
clear
nohup ngrok tcp 5901 --region ap &>/dev/null &
sleep 3
pan
echo -e "$blue Connect!"
echo -e "$yellow ==>  https://github.com/dinhductri202com/VKL-VPS-CODESPACE-. "
qemu-system-x86_64 -drive file=os.iso,media=cdrom -drive file=disk.img,format=raw -device usb-ehci,id=usb,bus=pci.0,addr=0x4 -device usb-tablet -vnc :1 -smp threads=1,sockets=1,cores=$core -device rtl8139,netdev=n0 -netdev user,id=n0 -vga qxl -m "$mem"M $lkvm  &>/dev/null &
printf ""$green"Your Address: "$reset""
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
while true # start an infinite loop
do
   sudo sync; echo 3 > /proc/sys/vm/drop_caches
   echo VKL VPS
   sleep 60 # wait for 1 second
done # end the loop
