# Sammy's Menus
Install Menu pages for Sammy's 3 monitor display for Raspberry Pi OS

## Prerequisites
* Three Raspberry Pi's (onboard Wi-Fi recommended)
* Raspberry Pi OS on all Pi's
* All Pi's connected to the same network and subnet

## Clone this repo
```
cd /home/pi && git clone https://github.com/sinpwnzorz/sammysmenus.git
```

## Setting up the first Pi
To setup Pi one which will be the primary menu and server for the other two.
```
chmod +x /home/pi/sammysmenus/setup.sh
sudo /home/pi/sammysmenus/setup.sh
```

To setup Pi two which will be one of the two clients to the primary server.
```
cd /home/pi/
wget http://sammysmenus/setup2.sh
chmod +x setup2.sh
sudo ./setup2.sh
```

To setup Pi three which will be the second and final of the two clients to the primary server.
```
cd /home/pi/
wget http://sammysmenus/setup3.sh
chmod +x setup3.sh
sudo ./setup3.sh
```
