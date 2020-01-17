orage &
# the custom keymap
xmodmap ~/.Xmodmap &
xbindkeys -v &

xset r rate 250 35 &
#xset s 3600
/usr/bin/urxvtd &
/usr/bin/nm-applet &
/usr/bin/owncloud &
/opt/urserver/urserver-start --no-manager --no-notify &
# sudo -u mpd mpd /home/dennis/.config/mpd/mpd.conf &
/home/dennis/bin/mpd_start.sh &

/home/dennis/bin/configme.sh &

# widgets
xload &
/home/dennis/bin/freemem.sh &
/home/dennis/bin/showvol.sh &


sleep 1
orage -t &

#exec awesome

echo xinitrc done
