### add some color
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
light_cyan='\033[1;96m'
reset='\033[0m'
#


pan()
{
### panner generator on website: https://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20
echo -e """
██╗   ██╗██╗  ██╗██╗         ██╗   ██╗██████╗ ███████╗
██║   ██║██║ ██╔╝██║         ██║   ██║██╔══██╗██╔════╝
██║   ██║█████╔╝ ██║         ██║   ██║██████╔╝███████╗
╚██╗ ██╔╝██╔═██╗ ██║         ╚██╗ ██╔╝██╔═══╝ ╚════██║
 ╚████╔╝ ██║  ██╗███████╗     ╚████╔╝ ██║     ███████║
  ╚═══╝  ╚═╝  ╚═╝╚══════╝      ╚═══╝  ╚═╝     ╚══════╝"""
}
check()
{
mem=`free --mega|grep Mem:|awk '{ print $7}'` && printf $yellow"Your MemAvailable: "$reset && echo -e $green"$mem" MB $reset
core=`lscpu|grep "CPU(s):" |awk '{print $2}'` && printf $yellow"Your Cores:"$reset && echo -e $green "$core" $reset
}
checkvm()
{
