# setup script to get API running on Raspberry Pi as daemon and a router
sudo apt-get update
sudo apt-get upgrade

# remove WPA Supplicant
sudo apt-get purge wpasupplicant

# Install DHCP Server
sudo apt-get install isc-dhcp-server

# Setup DHCP
sudo vi /etc/dhcp/dhcpd.conf
echo "subnet 172.16.1.0 netmask 255.255.255.0 {" >> /etc/dhcp/dhcpd.conf
echo "range 172.16.1.25 172.16.1.50;" >> /etc/dhcp/dhcpd.conf
echo "option domain-name-servers 8.8.4.4;" >> /etc/dhcp/dhcpd.conf
echo "option routers 172.16.1.1;" >> /etc/dhcp/dhcpd.conf
echo "interface wlan0;" >> /etc/dhcp/dhcpd.confecho
echo "}" >> /etc/dhcp/dhcpd.conf

# Install Host Access Point daemon
sudo apt-get install hostapd

# Configure hostapd
echo "interface=wlan0" >> /etc/hostapd/hostapd.conf
echo "#driver=nl80211" >> /etc/hostapd/hostapd.conf
echo "ssid=Sail_Sensors" >> /etc/hostapd/hostapd.conf
echo "hw_mode=g" >> /etc/hostapd/hostapd.conf
echo "channel=5" >> /etc/hostapd/hostapd.conf
echo "wpa=1" >> /etc/hostapd/hostapd.conf
echo "wpa_passphrase=Password" >> /etc/hostapd/hostapd.conf
echo "wpa_key_mgmt=WPA-PSK" >> /etc/hostapd/hostapd.conf
echo "wpa_pairwise=TKIP CCMP" >> /etc/hostapd/hostapd.conf
echo "wpa_ptk_rekey=600" >> /etc/hostapd/hostapd.conf
echo "macaddr_acl=0" >> /etc/hostapd/hostapd.conf

sudo ifconfig wlan0 172.16.1.1
sudo /etc/init.d/isc-dhcp-server restart

#Run in Debug Mode
sudo hostapd -d /etc/hostapd/hostapd.conf 

# 
echo "auto wlan0" >> /etc/network/interfaces
echo "iface wlan0 inet static" >> /etc/network/interfaces
echo "address 172.16.1.1" >> /etc/network/interfaces
echo "netmask 255.255.255.0" >> /etc/network/interfaces

# After Exit 0
echo "hostapd -B /etc/hostapd/hostapd.conf" >> /etc/rc.local
echo "iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE" >> /etc/rc.local

# Uncomment the next line to enable packet forwarding for IPv4
sed -i '/et.ipv4.ip_forward=1/s/^#//g' /etc/sysctl.conf

# Python
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
pyenv install 3.6.3
pyenv global 3.6.3
# Install MYSQL
sudo apt-get install mysql-server python-mysqldb

# Reboot
sudo reboot

