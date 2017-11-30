#!/bin/bash
#
# Configure OS after template is deployed.  
#
#
 
echo "Setting hostname..."
host=`hostname`
new_host=$1
cp /etc/hosts /etc/hosts.bkp
cp /etc/hostname /etc/hostname.bkp
cp /etc/mailname /etc/mailname.bkp
cat /etc/hosts.bkp | sed -e "s/$host/$new_host/g" > /etc/hosts
cat /etc/hostname.bkp | sed -e "s/$host/$new_host/g" > /etc/hostname
cat /etc/mailname.bkp | sed -e "s/$host/$new_host/g" > /etc/mailname
rm -vf /etc/hosts.bkp /etc/hostname.bkp /etc/mailname.bkp
 
echo "Cleaning /etc/rc.local..."
cat /dev/null > /etc/rc.local
cat << EOF >> /etc/rc.local
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
 
exit 0
EOF
 
echo "Process complete..."
reboot
