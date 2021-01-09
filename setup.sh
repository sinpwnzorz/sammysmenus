#!/bin/bash
#
# Run this setup.sh for one time deployment of the menus on the primary raspberry pi, run alternative setup methods on all clients
#

echo "Running preinstall update..."
sudo apt-get update -qq && sudo apt-get upgrade -qq -y && sudo apt autoremove -qq -y
echo "Installing Apache and unclutter"
sudo apt install apache2 -qq -y
sudo apt-get install unclutter -qq -y
echo -n "Webserver deployed at: http://" && hostname -I
mkdir /home/pi/sammysmenus
git clone https://github.com/sinpwnzorz/sammysmenus.git
mv /home/pi/sammysmenus/index.html /var/www/html/index.html
mv /home/pi/sammysmenus/page2.html /var/www/html/page2.html
mv /home/pi/sammysmenus/page3.html /var/www/html/page3.html
mv /home/pi/sammysmenus/style.css /var/www/html/style.css
mv /home/pi/sammysmenus/SammysBackground.jpg /var/www/html/SammysBackground.jpg
mv /home/pi/sammysmenus/SammysLogo.png /var/www/html/SammysLogo.png
rm -rf /home/pi/.config/*lxsession
mkdir -p /home/pi/.config/.lxsession/LXDE-pi
cat > /home/pi/.config/.lxsession/LXDE-pi/autostart <<EOF
@xset s off
@xset -dpms
@xset s noblank
@chromium --kiosk http://127.0.0.1
unclutter -idle 0
EOF
echo "Testing final envionment..."
timeout 10 chromium --kiosk http://127.0.0.1
while true; do
    read -p "Did the menu display properly?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo "Deploying triple-display webserver..."
mv /home/pi/.config/.lxsession/ /home/pi/.config/lxsession/
echo "Rebooting..."
sleep 2
reboot
