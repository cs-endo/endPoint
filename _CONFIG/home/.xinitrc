#!/bin/sh
cd ~

#export XAUTHORITY="$HOME/.temp/Xauthority"
export HISTFILE="$HOME/.temp/bash_history"

export VIMINIT="source $HOME/.config/vim/vimrc"

#xset +fp /usr/share/fonts/gnu-free
xset +fp /usr/share/fonts/100dpi
xset fp rehash

function get_date { date +"[%a %b %d %Y] %T"; }

function get_power { echo $( printf %02d $(cat /sys/class/power_supply/BAT0/capacity) ) ; }
function get_state { [[ $(cat /sys/class/power_supply/AC/online) -eq 1 ]] && echo "↑" || echo "↓" ; }

function get_cpu { 
	top -b -n1 -p 1 | fgrep "Cpu(s)" | tail -1 | \
awk -F'id,' -v prefix="$prefix" '{ split($1, vs, ","); \
v=vs[length(vs)]; sub("%", "", v); printf "%s%.2d%%\n", prefix, 100 - v }' ; }

function get_netTX { cat /sys/class/net/{enp0s25,wlp3s0}/statistics/tx_bytes | paste -sd+; }
function get_netRX { cat /sys/class/net/{enp0s25,wlp3s0}/statistics/rx_bytes | paste -sd+; }
function cln_netTX { echo $( printf %04d $(echo "(`get_netTX`-($netTX0)) / 1048576" | bc) ) ; }
function cln_netRX { echo $( printf %04d $(echo "(`get_netRX`-($netRX0)) / 1048576" | bc) ) ; }

function get_signal { signal=$(iwconfig wlp3s0 | grep Signal | cut -d' ' -f15 | cut -c7- ) ; echo [${signal:-#}] ; }

function get_dperc { df -h | grep $1 | cut -d' ' -f$2; }

netTX0="$(get_netTX)"; netRX0="$(get_netRX)";

while true; do
        menuText="`get_signal` `cln_netRX`↓ `cln_netTX`↑ - "
        menuText+="`get_cpu` - `get_state``get_power`% - "
        menuText+="SSD:`get_dperc sda4 15` - "
        menuText+="`get_date`"
        xsetroot -name "$menuText"
        sleep 1
done &

function on {
        xrandr --output VGA1 --off
        sleep 1
        xrandr --output VGA1 --auto --right-of LVDS1; ~/.fehbg
}

on &

exec dwm
