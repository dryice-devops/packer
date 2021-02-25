#!/bin/bash  
echo "HI"
whoami

#Ensure gpgcheck is globally activated
sudo sed -i '/^gpgcheck/c gpgcheck=1' /etc/yum.conf
ls /etc/yum.repos.d/  > /etc/yum.repos.d/great
cd /etc/yum.repos.d/
while read i;
do
a=$i
sed -i '/^gpgcheck/c gpgcheck=1' $a
 done < ./great
rm -f /etc/yum.repos.d/great
 
#Ensure AIDE is installed
sudo yum install aide -y
aide --init
mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
 
#Ensure filesystem integrity is regularly checked 
sudo echo '0 5 * * * /usr/sbin/aide --check' > /tmp/filenew
sudo crontab -u root -l | cat - /tmp/filenew | crontab -u root -
sudo rm -f /tmp/filenew
 
 
 
#Ensure the SELinux state is enforcing
sudo sed -i '/^SELINUX=/c SELINUX=enforcing' /etc/selinux/config

#Ensure SELinux policy is configured
sudo sed -i '/^SELINUXTYPE=/c SELINUXTYPE=targeted' /etc/selinux/config
 
#Ensure SETroubleshoot is not installed
sudo yum remove mcstrans -y
 
#Ensure no unconfined daemons exist
sudo ps -eZ | egrep "initrc" | egrep -vw "tr|ps|egrep|bash|awk" | tr ':' ' ' | awk '{ print $NF }'
 
#Ensure SELinux is installed
sudo yum install libselinux -y
  
#Ensure permissions
sudo chown root:root /etc/motd
sudo chmod 644 /etc/motd
sudo chown root:root /etc/issue
sudo chmod 644 /etc/issue
sudo chown root:root /etc/issue.net
sudo chmod 644 /etc/issue.net
 
#Ensure updates, patches, and additional security software are installed
sudo yum update --security -y 
 
 #Ensure time synchronization is in use
#sed -i '/^restrict/s/^/#/g' /etc/ntp.conf
sudo yum install ntp -y
sudo echo "restrict -4 default kod nomodify notrap nopeer noquery" >> /etc/ntp.conf
sudo echo "restrict -6 default kod nomodify notrap nopeer noquery" >> /etc/ntp.conf
 
#Ensure ntp is configured
sudo sed -i '/^OPTIONS/c OPTIONS="-u ntp:ntp"' /etc/sysconfig/ntpd
 
#Ensure chrony is configured
sudo yum install chrony -y
 
#Ensure X Window System is not installed
sudo yum remove -y xorg-x11* 

#Ensure NIS Client ,rsh,Talk,Telnet,LDAP is not installed
sudo yum remove -y ypbind
sudo yum remove -y rsh
sudo yum remove -y talk
sudo yum remove -y telnet
sudo yum remove -y openldap-clients
 

 
