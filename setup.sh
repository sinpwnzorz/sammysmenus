#!/bin/bash
echo "Running preinstall update..."
sudo apt-get update -qq && sudo apt-get upgrade -qq -y && sudo apt autoremove -qq -y
echo "Equipping AH-64 Apache2"
sudo apt install apache2 -qq -y
echo "Enabling Thermoptic mouse camouflage..."
sudo apt-get install unclutter
echo -n "Webserver deployed at: http://" && hostname -I
echo "Deploying Database Tractorbeam..."
if [ -d /home/pi/sammys ]
then
    rm -rf /home/pi/sammys
fi
mkdir /home/pi/sammys
wget -q --no-check-certificate 'https://docs.google.com/uc?export=download&id=1dWJbYRuWk1dkz1K3hfIDIyIxaP3xUETF' -O /home/pi/sammys/sammys.zip
echo "Decoupling High Priority Payload..."
unzip -q -o /home/pi/sammys/sammys.zip -d /var/www/html/
echo "Annihilating legacy architecture..."
rm -rf /home/pi/.config/*lxsession
mkdir -p /home/pi/.config/.lxsession/LXDE-pi
echo "Compiling autonomouns visualization..."
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
echo "Deploying triple-display matrix..."
mv /home/pi/.config/.lxsession/ /home/pi/.config/lxsession/
echo "Rebooting..."
sleep 1
reboot
