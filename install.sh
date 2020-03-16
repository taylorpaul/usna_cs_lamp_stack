# TODO: Update mAlpha Below:
​MALPHA="mXXXXXX"
#
# Script Globals/Software Versions (students should NOT update):
MYSQL_VERSION=5.7
PHP_VERSION=7.2
#
# NOTE: This script is taken from Jeff Kenney's installation instructions on http://apt.cs.usna.edu/notes for Ubuntu - Apache and MySQL Installation Guide.  When on the yard you can check that page for updates if something breaks with the script in the future!
#
# Install Required Ubuntu Packages for Apache - Mirroring CS Dept Configuration
sudo apt-get install -y php$PHP_VERSION apache2 php libapache2-mod-php$PHP_VERSION php$PHP_VERSION-mysql php$PHP_VERSION-curl php$PHP_VERSION-json php$PHP_VERSION-mysqlnd php$PHP_VERSION-gd libapache2-mod-perl2 php$PHP_VERSION-mbstring php$PHP_VERSION-xml libapache2-mod-php$PHP_VERSION php$PHP_VERSION-mysql php$PHP_VERSION-curl php$PHP_VERSION-json php$PHP_VERSION-mysqlnd php$PHP_VERSION-gd php$PHP_VERSION-xml libmysql-java graphviz libgraphviz-dev libmysql-java libapache-dbi-perl libmysql-java libapache2-mod-php$PHP_VERSION php$PHP_VERSION-mysql php$PHP_VERSION-curl php$PHP_VERSION-json php$PHP_VERSION-mysqlnd php$PHP_VERSION-gd libapache2-mod-perl2 php$PHP_VERSION-mbstring php$PHP_VERSION-xml php$PHP_VERSION-zip php$PHP_VERSION-json php$PHP_VERSION-sqlite3 libcgi-session-perl php-gd php-ssh2 php-xml
# NOTE: If/When prompted enter the machine sudo password
#
#
# Enable important Apache Modules
sudo a2enmod userdir
sudo a2enmod rewrite
sudo a2enmod cgi
sudo a2enmod ssl
sudo a2enmod perl
sudo a2enmod expires
sudo a2enmod headers
sudo a2enmod include
# NOTE: If/When prompted enter the machine sudo password
#
#
# Edit configuration to allow running PHP and CGI Scripts
sudo sed -i 's_FileInfo AuthConfig Limit Indexes_All_g' /etc/apache2/mods-enabled/userdir.conf
sudo sed -i 's_IncludesNoExec_ExecCGI\n\t\tAddhandler cgi-script .py .cgi_g' /etc/apache2/mods-enabled/userdir.conf
sudo sed -i 's=php_admin_flag engine Off=#php_admin_flag engine Off=g' /etc/apache2/mods-enabled/php$PHP_VERSION.conf
sudo sed -i 's|post_max_size = 8M|post_max_size = 24M|g' /etc/php/$PHP_VERSION/apache2/php.ini
sudo sed -i 's|upload_max_filesize = 2M|upload_max_filesize = 24M|g' /etc/php/$PHP_VERSION/apache2/php.ini
sudo sed -i 's|Options Indexes FollowSymLinks|Options Indexes FollowSymLinks ExecCGI|g' /etc/apache2/apache2.conf
#NOTE: for compatability with non-GNU version of sed, save output to a tmp file and then mv to original file
sudo sed -e '/Options Indexes FollowSymLinks/{s//Options Indexes FollowSymLinks ExecCGI\n\tAddhandler cgi-script .py .cgi/;:a' -e '$!N;$!ba' -e '}' /etc/apache2/apache2.conf > apache2.conf.tmp
sudo mv apache2.conf.tmp /etc/apache2/apache2.conf
sudo rm apache2.conf.tmp
# If/When prompted enter the machine sudo password
​#
#
​
# # TODO: Stopped HERE!!!
#
# # 2) CHANGE DOCUMENT ROOT TO PUBLIC_HTML DIR:
# ​
# # Changing apache2 document root
# ​
# # The default document root is set in the 000-default.conf file that is under /etc/apache2/sites-available folder.
# ​
# $ cd /etc/apache2/sites-available
# ​
# $ sudo nano 000-default.conf
# ​
# # While the file is opened change DocumentRoot /var/www/ with your new folder e.g DocumentRoot /home/shprink/Sites/
# ​
# # Set the right Apache configuration
# ​
# T# he configuration of the /etc/www folder is under /etc/apache2/apache2.conf. Edit this file to add the configuration of your new document root.
# ​
# $ sudo nano /etc/apache2/apache2.conf
# ​
# # Copy the following:
# ​
# <Directory /var/www/>
# ​
#        Options Indexes FollowSymLinks
# ​
#        AllowOverride None
# ​
#        Require all granted
# ​
# </Directory>
# ​
# # and change the directory path:
# ​
# <Directory /home/<YOUR_USER_NAME>/public_html> # MAKE THIS MATCH your pathto ~/public_html!!
# ​
#        Options Indexes FollowSymLinks
# ​
#        AllowOverride None
# ​
#        Require all granted
# ​
# </Directory>
# ​
# Restart Apache
# ​
# $ sudo service apache2 restart
# ​
# # Set the right permission
# ​
# # All of your document root parent folders must be executable by everyone. To know if it is the case you can use the utility namei that list the permissions along each component of the path:
# ​
# $ namei -m /home/shprink/Sites/
# ​
# # f: /home/shprink/Sites/
# ​
#  # drwxr-xr-x /
# ​
#  # drwxr-xr-x home
# ​
# #  drwx------ shprink
# ​
#  # drwx------ Sites
# ​
# # Here as you can see that shprink and Sites permissions are not set properly.
# ​
# # Open http://localhost/ in your browser, you should get the following message:
# ​
# # Forbidden
# ​
# # You don’t have permission to access / on this server.
# ​
# # Open the apache error log to see the exact error code e.g AH00035. It might help you to get more information.
# ​
# $ sudo tail -f /var/log/apache2/error.log
# ​
# # [Mon Apr 06 09:04:26.518260 2015] [core:error] [pid 22139] (13)Permission denied: [client 127.0.0.1:45121] AH00035: access to / denied (filesystem path '/home/shprink/Sites') because search permissions are missing on a component of the path
# ​
# # To fix the permission problem for good, using chmod +755 should be enough.
# ​
# $ chmod +755 /home/shprink/
# ​
# $ chmod +755 /home/shprink/Sites/
# ​
# # Re run namei to make sure everything is ok.
# ​
# $ namei -m ~/Sites/
# ​
# # f: /home/shprink/Sites/
# ​
#  # drwxr-xr-x /
# ​
#  # drwxr-xr-x home
# ​
#  # drwxr-xr-x shprink
# ​
# # drwxr-xr-x Sites
# ​
# ​
# # Change Port number, ITSD blocks hosts from using port 80:
# sudo vim /etc/apache2/ports.conf
# ​
# # Change the port number to a port of your choice, recommend 81:
# Listen 80 -> Listen 81
# ​
# # Restart and test apache:
# sudo service apache2 restart
# ​
# # Now opening http://localhost:81/ should work as expected.
# ​
# ​
# # Start MySQL service:
# ​
# Sudo service mysql restart
# ​
# # Create username:
# GRANT ALL PRIVILEGES ON *.* TO 'mALPHA'@'localhost' IDENTIFIED BY 'password';
# ​
# # Login as username:
# ​
# # Type exit and then relogin from WSL:
# mysql -u mALPHA -p                 # (Notice no -h here, we are connecting to mysql running on our localhost!)
# ​
# # CREATE a Database:
# ​
# CREATE DATABASE mALPHA;
# ​
# USE mALPHA;
# ​
# # NOTE: In your mysql.inc.php file, have a login set for localhost and if you use the same uname, schema and password for your local mysql copy, you will connect to the right instance depending on where you are running your code!
