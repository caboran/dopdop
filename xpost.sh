#!/bin/bash
echo " "
BoZabo='\e[40;38;5;82m' #BoZabo
jo='\e[0m' # pa BOTAA
os=$(exec uname -m|grep 64)
if [ "$os" = "" ]
then os="x86"
else os="x64"
fi
echo -e "${BoZabo} ┌───────────────────────────┐ \e[0m"
echo -e "${BoZabo} │  Checking System Version  │ \e[0m"
echo -e "${BoZabo} └───────────────────────────┘ \e[0m"
sleep 3
echo -e "${BoZabo} ┌───────────────────────────┐ \e[0m"
echo -e "${BoZabo} │   Detected a $os System   │ \e[0m"
echo -e "${BoZabo} └───────────────────────────┘ \e[0m"
sleep 3
echo -e "${BoZabo} ┌───────────────────────────┐ \e[0m"
echo -e "${BoZabo} │   Installing XMailServer   │ \e[0m"
echo -e "${BoZabo} └───────────────────────────┘ \e[0m"
echo " "
apt-get update && apt-get upgrade -y && apt-get install apache2 php -y
service apache2 restart
sudo apt-get install postfix -y
sudo dpkg-reconfigure postfix
#sudo -i
#sudo echo "home_mailbox = Maildir/" >> /etc/postfix/main.cf
#sudo echo "smtpd_sasl_type = dovecot" >> /etc/postfix/main.cf
#sudo echo "smtpd_sasl_path = private/auth" >> /etc/postfix/main.cf
#sudo echo "smtpd_sasl_local_domain = " >> /etc/postfix/main.cf
#sudo echo "smtpd_sasl_security_options = noanonymou" >> /etc/postfix/main.cf
#sudo echo "broken_sasl_auth_clients = yes" >> /etc/postfix/main.cf
#sudo echo "smtpd_sasl_auth_enable = yes" >> /etc/postfix/main.cf
#sudo echo "smtpd_recipient_restrictions = permit_networks, permit_sasl_authenticated, rejet_unauth_destination" >> /etc/postfix/main.cf
#sudo echo "smtpd_client_restrictions = permit_networks, permit_sasl_authenticated, reject_unknown_client_hostname" >> /etc/postfix/main.cf
#sudo echo "smtp_tls_security_level = may" >> /etc/postfix/main.cf
#sudo echo "smtpd_tls_security_level = may" >> /etc/postfix/main.cf
#sudo echo "smtp_tls_note_starttls_offer = yes" >> /etc/postfix/main.cf
#sudo echo "smtpd_tls_loglevel = 1" >> /etc/postfix/main.cf
#sudo echo "smtpd_tls_received_header = yes" >> /etc/postfix/main.cf
#sudo echo "smtpd_helo_required = yes" >> /etc/postfix/main.cf
#sudo echo "smtpd_helo_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_non_fqdn_hostname, reject_invalid_hostname" >> /etc/postfix/main.cf
sudo postconf -e 'home_mailbox = Maildir/'
sudo postconf -e 'smtpd_sasl_type = dovecot'
sudo postconf -e 'smtpd_sasl_path = private/auth'
sudo postconf -e 'smtpd_sasl_local_domain = '
sudo postconf -e 'smtpd_sasl_security_options = noanonymous'
sudo postconf -e 'broken_sasl_auth_clients = yes'
sudo postconf -e 'smtpd_sasl_auth_enable = yes'
sudo postconf -e 'smtpd_recipient_restrictions = permit_networks, permit_sasl_authenticated, rejet_unauth_destination'
sudo postconf -e 'smtpd_client_restrictions = permit_networks, permit_sasl_authenticated, reject_unknown_client_hostname'
sudo postconf -e 'smtp_tls_security_level = may'
sudo postconf -e 'smtpd_tls_security_level = may'
sudo postconf -e 'smtp_tls_note_starttls_offer = yes'
sudo postconf -e 'smtpd_tls_loglevel = 1'
sudo postconf -e 'smtpd_tls_received_header = yes'
sudo postconf -e 'smtpd_helo_required = yes'
sudo postconf -e 'smtpd_helo_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_non_fqdn_hostname, reject_invalid_hostname'
openssl genrsa -des3 -out server.key 4096
openssl rsa -in server.key -out server.key.insecure
mv server.key server.key.secure
mv server.key.insecure server.key
openssl req -new -key server.key -out server.csr
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
sudo cp server.crt /etc/ssl/certs
sudo cp server.key /etc/ssl/private
sudo postconf -e 'smtpd_tls_key_fille = /etc/ssl/private/server.key'
sudo postconf -e 'smtpd_tls_cert_fille = /etc/ssl/certs/server.crt'
wget -q https://raw.githubusercontent.com/caboran/dopdop/main/main.cfs -O /etc/postfix/main.cf
wget -q https://raw.githubusercontent.com/caboran/dopdop/main/master.cfs -O /etc/postfix/master.cf
sudo service postfix restart
sudo service dovecot restart
sudo apt-get install unzip -y
cd /var/www/html
wget http://logicielcaisseimprimanteticket.com/wp-content/abdou.zip
unzip abdou
echo " "
echo -e "${BoZabo} ┌────────────────────────────────┐ \e[0m"
echo -e "${BoZabo} │   INSTALLATION WELL-DONE...  │ \e[0m"
echo -e "${BoZabo} └────────────────────────────────┘ \e[0m"
echo " "
echo " "
echo -e "${BoZabo} ┌────────────────────────────────┐ \e[0m"
echo -e "${BoZabo} │ main.cf for the hostname  │ \e[0m"
echo -e "${BoZabo} └────────────────────────────────┘ \e[0m"
echo " "
echo -e "${BoZabo} ┌────────────────────────────────┐ \e[0m"
echo -e "${BoZabo} │ EDIT 10-master.conf & 10-auth.conf  │ \e[0m"
echo -e "${BoZabo} └────────────────────────────────┘ \e[0m"
echo " "
echo -e "${BoZabo} ┌────────────────────────────────┐ \e[0m"
echo -e "${BoZabo} │ A ml - MX ml ml  │ \e[0m"
echo -e "${BoZabo} └────────────────────────────────┘ \e[0m"
echo " "
echo -e "${BoZabo} ┌────────────────────────────────┐ \e[0m"
echo -e "${BoZabo} │ TXT v=spf1 ip4: -all  │ \e[0m"
echo -e "${BoZabo} └────────────────────────────────┘ \e[0m"
echo " "
sudo postconf -e 'smtp_generic_maps = hash:/etc/postfix/generic'
sudo echo "www-data generic" >> /etc/postfix/generic
sudo postmap /etc/postfix/generic
echo " "
echo -e "${BoZabo} â”
echo -e "${BoZabo} ┌──────────────────────────────────────────────────────────┐ \e[0m"
echo -e "${BoZabo} │  XPost Fuckers 1.2  								   │ \e[0m"
echo -e "${BoZabo} └──────────────────────────────────────────────────────────┘ \e[0m"
echo -e "${BoZabo} ┌──────────────────────────────────────────────────────────┐ \e[0m"
echo -e "${BoZabo} │[+] installation Completed      Thanks to THEBOTA..                       │ \e[0m"
echo -e "${BoZabo} └──────────────────────────────────────────────────────────┘ \e[0m"
echo " "
sleep 8
reboot
echo " "
echo -e "${BoZabo} ┌───────────────────────┐ \e[0m"
echo -e "${BoZabo} │[R]  Rebooting VPS...  │ \e[0m"
echo -e "${BoZabo} └───────────────────────┘ \e[0m"
echo " "
