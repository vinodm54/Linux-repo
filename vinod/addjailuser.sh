#!/bin/sh
#Jailuser creation on Linux
#16-May-2020
#created by vinod M
for a in 'cat /opt/scripts/hostname.txt';
do	for b in 'cat /opt/scripts/username.txt';
	do echo $a $b;
	user="$(cut -d',' -f1<<<"$b")"
	pass="$(cut -d',' -f2<<<"$b")"
	ssh $a "useradd -s /sbin/rbash '$user'; echo -e '$pass\n$pass' | passwd '$user';\
	cd /home/$user;\
	rm -rf .bash_logout .bash_profile .bashrc .profile .bash_login .emacs .mozilla;\
	mkdir /home/$user/bin;\
	cd /home/$user/bin;\
	ln -s /bin/ping ping;\
	ln -s /usr/bin/ls ls;\
	ln -s /usr/bin/snmpwalk snmpwal;\
	ln -s /bin/bash /bin/rbash;\
	chmod 2070 -R /home/$user;\
	chown root:$user /home/$user;\
	chown root:root /home/$user/bin -Rf;\
        chmod -Rf 755 /home/$user/bin;\
        chmod u+s /home/$user/bin/ping;"
        rsync -azP .profile root@$a:/home/$user;\
        ssh $a "chown root:$user /home/$user/.profile && chmod 750 /home/$user/.profile";done
done
