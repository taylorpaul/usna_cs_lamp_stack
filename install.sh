# BETA!!! NOTE I AM STILL WORKING TO VERIFY INSTALL WITH A STUDENT:
​
#PRE: Install WSL
​
# Windows Key, type power shell, right click and run as administrator 
​
# Run: 
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux 
​
# Restart if prompted! 
​
# Open admin power shell again: 
​
# Run: 
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile Ubuntu.appx -UseBasicParsing 
​
 
​
# NOTE: You willl see Number of bytes written and it will take 2-3 mins to complete 
​
# Run: 
Add-AppxPackage .\Ubuntu.appx 
​
# Update WSL:
sudo apt update && sudo apt upgrade
​
​
################################################################################
​
# 1) INSTALL NECESSARY APACHE/MYSQL AND CONFIGURE 
​
# MySQL and Apache (Servers) 
​
sudo apt-get install -y mysql-server-5.7 php7.0 apache2 php libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-json php7.0-mysqlnd php7.0-gd libapache2-mod-perl2 php7.0-mbstring php7.0-xml 
​
 
​
# Database and web stuff (Servers) 
​
sudo apt-get -y install libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-json php7.0-mysqlnd php7.0-gd php7.0-xml 
​
 
​
mkdir ~/public_html 
​
sudo a2enmod userdir 
​
sudo a2enmod rewrite 
​
sudo a2enmod cgi 
​
sudo a2enmod ssl 
​
sudo a2enmod perl 
​
sudo a2enmod expires 
​
sudo a2enmod headers 
​
sudo a2enmod include 
​
 
​
sudo vi /etc/apache2/mods-enabled/userdir.conf 
​
# line 6,7: change 
​
#  AllowOverride All 
​
#  Options ExecCGI Indexes FollowSymLinks MultiViews 
​
#  AddHandler cgi-script .py .cgi 
​
 
​
sudo vi /etc/apache2/mods-enabled/php7.0.conf 
​
# line 25: comment out 
​
#  php_admin_flag engine Off 
​
 
​
sudo service apache2 restart 
​
 
​
sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf 
​
# add the following line 
​
sql_mode = "STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" 
​
 
​
 
​
 
​
 
#############################################################################
​
# 2) CHANGE DOCUMENT ROOT TO PUBLIC_HTML DIR: 
​
# Changing apache2 document root 
​
# The default document root is set in the 000-default.conf file that is under /etc/apache2/sites-available folder. 
​
$ cd /etc/apache2/sites-available 
​
$ sudo nano 000-default.conf 
​
# While the file is opened change DocumentRoot /var/www/ with your new folder e.g DocumentRoot /home/shprink/Sites/ 
​
# Set the right Apache configuration 
​
T# he configuration of the /etc/www folder is under /etc/apache2/apache2.conf. Edit this file to add the configuration of your new document root. 
​
$ sudo nano /etc/apache2/apache2.conf 
​
# Copy the following: 
​
<Directory /var/www/> 
​
       Options Indexes FollowSymLinks 
​
       AllowOverride None 
​
       Require all granted 
​
</Directory> 
​
# and change the directory path: 
​
<Directory /home/<YOUR_USER_NAME>/public_html> # MAKE THIS MATCH your pathto ~/public_html!!
​
       Options Indexes FollowSymLinks 
​
       AllowOverride None 
​
       Require all granted 
​
</Directory> 
​
Restart Apache 
​
$ sudo service apache2 restart 
​
# Set the right permission 
​
# All of your document root parent folders must be executable by everyone. To know if it is the case you can use the utility namei that list the permissions along each component of the path: 
​
$ namei -m /home/shprink/Sites/ 
​
# f: /home/shprink/Sites/ 
​
 # drwxr-xr-x / 
​
 # drwxr-xr-x home 
​
#  drwx------ shprink 
​
 # drwx------ Sites 
​
# Here as you can see that shprink and Sites permissions are not set properly. 
​
# Open http://localhost/ in your browser, you should get the following message: 
​
# Forbidden 
​
# You don’t have permission to access / on this server. 
​
# Open the apache error log to see the exact error code e.g AH00035. It might help you to get more information. 
​
$ sudo tail -f /var/log/apache2/error.log 
​
# [Mon Apr 06 09:04:26.518260 2015] [core:error] [pid 22139] (13)Permission denied: [client 127.0.0.1:45121] AH00035: access to / denied (filesystem path '/home/shprink/Sites') because search permissions are missing on a component of the path 
​
# To fix the permission problem for good, using chmod +755 should be enough. 
​
$ chmod +755 /home/shprink/ 
​
$ chmod +755 /home/shprink/Sites/ 
​
# Re run namei to make sure everything is ok. 
​
$ namei -m ~/Sites/ 
​
# f: /home/shprink/Sites/ 
​
 # drwxr-xr-x / 
​
 # drwxr-xr-x home 
​
 # drwxr-xr-x shprink 
​
# drwxr-xr-x Sites 
​
​
# Change Port number, ITSD blocks hosts from using port 80: 
sudo vim /etc/apache2/ports.conf 
​
# Change the port number to a port of your choice, recommend 81: 
Listen 80 -> Listen 81 
​
# Restart and test apache: 
sudo service apache2 restart 
​
# Now opening http://localhost:81/ should work as expected. 
​
​
# Start MySQL service: 
​
Sudo service mysql restart 
​
# Create username: 
GRANT ALL PRIVILEGES ON *.* TO 'mALPHA'@'localhost' IDENTIFIED BY 'password'; 
​
# Login as username: 
​
# Type exit and then relogin from WSL: 
mysql -u mALPHA -p                 # (Notice no -h here, we are connecting to mysql running on our localhost!) 
​
# CREATE a Database: 
​
CREATE DATABASE mALPHA; 
​
USE mALPHA; 
​
# NOTE: In your mysql.inc.php file, have a login set for localhost and if you use the same uname, schema and password for your local mysql copy, you will connect to the right instance depending on where you are running your code! 