#!/bin/bash
#
# Run this setup.sh for one time deployment of the menus on the primary raspberry pi, use the following on the other two screens
#wget http://sammysmenu/setup2.sh && ./setup2.sh
#wget http://sammysmenu/setup3.sh && ./setup3.sh
#

echo "Running preinstall update..."
sudo apt-get update -qq && sudo apt-get upgrade -qq -y && sudo apt autoremove -qq -y
echo "Installing Apache and unclutter"
sudo apt install apache2 -qq -y
sudo apt-get install unclutter -qq -y
echo $(hostname -I)" sammysmenus" >> /etc/hosts
echo '127.0.0.1 sammysmenus' >> /etc/hosts
echo 'sammysmenus' >> /etc/hostname
echo -n "Webserver deployed at: http://" && hostname -I
echo -n "Also available at: http://" && hostname
mkdir /home/pi/sammysmenus
git clone https://github.com/sinpwnzorz/sammysmenus.git
cd /home/pi/sammysmenus
mv setup2.sh setup3.sh index.html page2.html page3.html style.css SammysBackground.jpg SammysLogo.png /var/www/html/
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
