#!/bin/sh
setxkbmap us
sleep 5 && xdotool type --delay=50 --clearmodifiers "ks=http://git.giraf.cs.aau.dk/Giraf17-Tools/kickstart-files/raw/master/centos7-master.cfg ip=172.19.0.251::172.19.0.225:255.255.255.128:master.giraf.cs.aau.dk:ens160:none nameserver=172.21.96.154 nameserver=172.21.96.25"
