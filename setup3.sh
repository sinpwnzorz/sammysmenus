#/!bin/bash
sudo apt-get install unclutter -y
mkdir -p /home/pi/.config/lxsession/LXDE-pi
cat > /home/pi/.config/lxsession/LXDE-pi/autostart <<EOF
@xset s off
@xset -dpms
@xset s noblank
@chromium --kiosk http://192.168.1.84/page3.html
unclutter -idle 0
EOF
